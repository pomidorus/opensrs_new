require 'nokogiri'
require 'opensrs'

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
  attr :request_hash, :client_hash

  def initialize(request_hash, client_hash)
    @request_hash, @client_hash = request_hash, client_hash
  end


  def action
    request_hash["action"]
  end

  def object
    request_hash["object"]
  end

  def reg_type
    request_hash["reg_type"]
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

  def response
    case action
      when "GET_ORDER_INFO"
        "order_info_response"
      when "GET_PRODUCT_INFO"
        "product_info_response"
      when "SW_REGISTER"
        return "renew_an_order_to_upgrade_a_sitelock_ssl_certificate_to_sitelock_premium" if reg_type == "upgrade"
        return "renew_a_new_order_for_a_quickssl_certificate_based_on_an_existing_order" if reg_type == "new" && product_type == "quickssl"
        return "renew_an_order_for_a_30_day_free_trial_of_a_symantec_securesite_certificate" if reg_type == "new" && product_type == "securesite_ft"
        return "renew_an_order_for_a_geotrust_web_site_anti_malware_scan_certificate" if reg_type == "new" && product_type == "malwarescan"

        return "renew_a_renewal_order_for_a_quickssl_certificate_that_was_submitted_by_using_the_order_id" if reg_type == "renew" && !order_id.blank?
        return "renew_a_renewal_order_for_a_quickssl_certificate_that_was_submitted_by_using_the_product_id" if reg_type == "renew" && !inventory_item_id.blank?
        return "renew_renewal_order_for_a_quickssl_certificate" if reg_type == "renew" && !product_id.blank?
        return "register_ssl_cert_response"
      when "CANCEL_ORDER"
        "cancel_order_response"
      when "PARSE_CSR"
        "parse_csr_response"
      when "QUERY_APPROVER_LIST"
        "approver_list_response"
      when "RESEND_APPROVE_EMAIL"
        "resend_approve_email"
      when "RESEND_CERT_EMAIL"
        "resend_certificate_email"
    end
  end

end

def client_function(hash)
  {}
end

def authenticate_client_function(user,key)
  "hello #{user}"
end

class OpensrsController < ApplicationController
  respond_to :xml, :only => :index
  #before_filter :authenticate_user

  def index
    username = request.headers["X-Username"]
    signature = request.headers["X-Signature"]
    #Client function for auth
    authenticate_client_function(username,signature)
    opensrs_request = OpenSRSRequestParse.new(request.body.read).request_hash
    #Client function
    hash = client_function(opensrs_request)
    opensrs_response = OpenSRSResponse.new(opensrs_request,hash)
    render "layouts/#{opensrs_response.response}", :formats => [:xml]
  end
end


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
