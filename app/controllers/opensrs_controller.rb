require 'nokogiri'
require 'opensrs'


# ssl_certificate = {
#   :nomenclature_id => :integer,

#   :csr => :text,

#   :common_name => :string,
#   :validation_email => :string,

#   :additional_domains => :text,
#   :additional_validation_emails => :text,

#   :country => :string,
#   :zip => :string,
#   :stateorprovincename => :string,
#   :city => :string,
#   :street1 => :string,
#   :street2 => :string,
#   :organisation_name => :string,
#   :organisation_unit => :string,

#   :server_count => :integer,
#   :domain_count => :integer,
#   :ssl_server_software_id => :integer,

#   :duration => :integer,
#   :valid_from => :date,
#   :valid_to => :date,

#   :issuer_order_number => :string,
#   :provider_order_number => :string,
#   :serial_number => :string,

#   :certificate_state => :string,
#   :issuer_order_date => :datetime,
#   :issuer_order_state => :string,
#   :issuer_order_state_additional => :string, #только для Comodo
#   :issuer_order_state_minor_code => :string, #только для Comodo
#   :issuer_order_state_minor_name => :string, #только для Comodo

#   :issued_dt => :datetime,
#   :our_sell_price => :decimal,
#   :our_sell_currency => :string,

#   :admin_contact_person_id => :integer,
#   :tech_contact_person_id => :integer,
#   :callback_contact_person_id => :integer,

#   :approver_notified_date => :datetime,
#   :approver_confirm_date => :datetime,

#   :organisation_phone => :string,
#   :organisation_fax => :string,

#   :provider_id => :integer,

#   :company_number => :string,
#   :dcv_method => :string,
# }

# contact_person = {
#   :first_name => :string,
#   :last_name => :string,
#   :phone => :string,
#   :fax => :string,
#   :email => :string,
#   :title => :string,
#   :organization_name => :string,
#   :address_line_1 => :string,
#   :address_line_2 => :string,
#   :city => :string,
#   :region => :string,
#   :postal_code => :string,
#   :country => :string,
#   :country_id => :integer
# }

class SslProxy
  # empty
end

class OpenSRSClient < SslProxy
    attr :request, :username, :signature

    def authenticate?
      # code for authentication
      false
      true
    end

    def initialize(request, username, signature)
      @request, @username, @signature = request, username, signature
    end

    def response

    end

    def product_info(code)
      {
        :code => :string,
        :name => :string,
        :price => :decimal,
        :certificate_type => %w{standart wildcard ucc code_signing},
        :validation_type => %w{ov dv},
        :is_ev => :boolean,
        :is_sgc => :boolean,
        :issuer_organization_name => :string,
        :is_free => :boolean,
        :discontinued => :boolean,
        :is_email_validated => :boolean,
        :domain_name => 'example.ru'
      }
    end

    def order_info(order_number)
      {
        :order_id => order_number
      }
    end

    def cancel_order(order_number)
     {
        domain_name: 'example.ru',
        order_id: order_number,
        state: 'Moscow'
      }
    end

    def parse_csr(domain_name)
      {
        domain_name: 'example.ru',
        country: 'RU',
        email: '',
        locality: 'Moscow',
        organization: 'ZAO Example',
        organization_unit: 'IT',
        state: 'Moscow'
      }
    end

    def register_ssl_cert(order_number)
     {
        domain_name: 'example.ru',
        order_id: order_number,
      }
    end

    def approver_list(order_number)

    end

    def resend_approve_email(order_number)

    end

    def resend_cert_email(order_number)

    end

  end


class OpenSRSRequestParse
  attr :xml

  def initialize(xml)
    @xml = xml
  end

  def request_hash
    request = Nokogiri::XML(xml)
    rh = {}
    request.xpath('//OPS_envelope/dt_assoc/item').each do |item|
      rh[item['key']] = item.content unless item['key'] == "attributes"
    end
    request.xpath('//OPS_envelope/dt_assoc/item/dt_assoc/item').each do |item|
      rh[item['key']] = item.content
    end
    rh
  end
end

class OpenSRSResponse
  attr :request_hash

  SRS_ACTION = "action"
  SRS_OBJECT = "object"
  SRS_REG_TYPE = "reg_type"
  GET_ORDER_INFO = "GET_ORDER_INFO"
  GET_ORDER_INFO_RESPONSE = "order_info_response"

  ACTION_RESPONSE = {GET_ORDER_INFO => GET_ORDER_INFO_RESPONSE}

  def initialize(request_hash)
    @request_hash = request_hash
  end

  def client_data
    {}
  end

  def render_layout
  end

  def action
    request_hash[SRS_ACTION]
  end

  def object
    request_hash[SRS_OBJECT]
  end

  def reg_type
    request_hash[SRS_REG_TYPE]
  end

  def product_type
    request_hash["product_type"]
  end

  def order_id
    request_hash["order_id"]
  end

  def inventory_item_id
    request_hash["inventory_item_id"]
  end

  def product_id
    request_hash["product_id"]
  end

  def response(item_open_srs_client)
    result = {}

    case action
      when GET_ORDER_INFO
        result[:data] = item_open_srs_client.order_info(@request_hash["order_id"])
        result[:layout] = ACTION_RESPONSE[GET_ORDER_INFO]

      when "GET_PRODUCT_INFO"
        result[:data] = item_open_srs_client.product_info('some code')
        result[:layout] = "product_info_response"

      when "SW_REGISTER"
        if reg_type == "upgrade"
          result[:layout] = "renew_an_order_to_upgrade_a_sitelock_ssl_certificate_to_sitelock_premium"
        elsif reg_type == "new" && product_type == "quickssl"
          result[:layout] = "renew_a_new_order_for_a_quickssl_certificate_based_on_an_existing_order"
        elsif reg_type == "new" && product_type == "securesite_ft"
          result[:layout] = "renew_an_order_for_a_30_day_free_trial_of_a_symantec_securesite_certificate"
        elsif reg_type == "new" && product_type == "malwarescan"
          result[:layout] = "renew_an_order_for_a_geotrust_web_site_anti_malware_scan_certificate"

        elsif reg_type == "renew" && !order_id.blank?
          result[:layout] = "renew_a_renewal_order_for_a_quickssl_certificate_that_was_submitted_by_using_the_order_id"
        elsif reg_type == "renew" && !inventory_item_id.blank?
          result[:layout] = "renew_a_renewal_order_for_a_quickssl_certificate_that_was_submitted_by_using_the_product_id"
        elsif reg_type == "renew" && !product_id.blank?
          result[:layout] = "renew_renewal_order_for_a_quickssl_certificate"
        else
          result[:data] = item_open_srs_client.register_ssl_cert(@request_hash["order_id"])
          result[:layout] = "register_ssl_cert_response"
        end

      when "CANCEL_ORDER"
        result[:data] = item_open_srs_client.cancel_order(@request_hash["order_id"])
        result[:layout] = "cancel_order_response"

      when "PARSE_CSR"
        result[:data] = item_open_srs_client.parse_csr(@request_hash["domain_name"])
        result[:layout] = "parse_csr_response"

      when "QUERY_APPROVER_LIST"
        result[:layout] = "approver_list_response"

      when "RESEND_APPROVE_EMAIL"
        result[:layout] = "resend_approve_email"

      when "RESEND_CERT_EMAIL"
        result[:layout] = "resend_certificate_email"
    end

    result
  end

end

class OpensrsController < ApplicationController
  respond_to :xml, :only => :index

  def index
    username = request.headers["X-Username"]
    signature = request.headers["X-Signature"]

    opensrs_request_hash = OpenSRSRequestParse.new(request.body.read).request_hash
    opensrs = OpenSRSClient.new(opensrs_request_hash,username,signature)
    if opensrs.authenticate?
      command = OpenSRSResponse.new(opensrs_request_hash).response(opensrs)

      response_hash = opensrs.response # at this moment always empty

      # data for layout
      @data = command[:data]
      _debug 'data', @data
      render "layouts/#{command[:layout]}", :formats => [:xml]
    else
      render "layouts/bad_authorization", :formats => [:xml]
    end
  end
end

  #before_filter :authenticate_user
    #opensrs_response = OpenSRSResponse.new(opensrs_request)
    #client_data = opensrs_response.client_data


    #puts opensrs_response.at_css("item").text
    #attributes = {:foo => {:bar => 'baz'}}
    #xxml = OpenSRS::XmlProcessor::Nokogiri.build(attributes)
    #puts xxml
    #render :xml => xml_body
    #OpenSRS::Server.xml_processor = :nokogiri

    # Rails.logger.debug "#{authenticate_client_function(username,signature)}"
  #private
  #def authenticate_user
  #  username = request.headers["X-Username"]
  #  signature = request.headers["X-Signature"]
  #  @current_user = User.find_by_signature(signature)
  #    #unless @current_user
  #    #  respond_with({:error => "Signature is invalid." })
  #    #end
  #end
    # Rails.logger.debug "#{opensrs_request.inspect}"
    # Rails.logger.debug "#{opensrs_response.response.inspect}"
