require 'nokogiri'
#require 'opensrs'
require 'xmlsimple'
require "rexml/document"


CLIENT_CONTACT = {
  first_name: "Andrey",
  last_name: "Seleznov",
  org_name: "Example Inc.",
  address1: "32 Oak St.",
  address2: "Suite 500",
  city: "Santa Clara",
  region: "Donbass",
  country: "RU",
  postal_code: "90210",
  phone: "+1.4165550123x1902",
  fax: "+1.4165550124",
  email: "owner@example.com",
  title: "mr",
  country_id: "1"
}


GET_PRODUCT_INFO_ALL_HASH = {
  csr_data: {
    country: "Ukraina",
    organization_unit: "QA Dept",
    valid_true_domain: "1",
    state: "CA",
    locality: "Santa Clara",
    email: "qafive@example.com",
    domain: "abc123.example.org",
    valid_quick_domain: "1",
    has_bad_extensions: "0",
    organization: "Example Co."
  },
  notes_list: [
    {date: "2012-04-12T10:05:08.000-05:00", type: "product_active", note: "The product with the id [2071] has been created."}
  ],
  expiry_date: "2013-04-12T18:59:59.000-05:00",
  state: "active",
  product_type: "sitelock_premium",
  domain: "trust.example.org",
  issue_date: "2012-04-12T10:02:01.000-05:00",
  product_id: "2071",
  is_renewable: "0",
  contact_email: "qafive@example.com",
  contact_set: {
    admin: CLIENT_CONTACT,
    tech: CLIENT_CONTACT,
    organization: CLIENT_CONTACT,
    billing: CLIENT_CONTACT
  },
  csr: "-----BEGIN CERTIFICATE REQUEST----- MIIC2TCCAcECAQAwgZMxIDAeBgNVBAMTF3NzbDEyMy5xYXJlZ3Jlc3Npb24ub3Jn MQswCQYDVQQGEwJDQTELMAkGA1UECBMCT04xEDAOBgNVBAcTB1Rvcm9udG8xDzAN BgNVBAoTBlR1Y293czEQMA4GA1UECxMHUUEgRGVwdDEgMB4GCSqGSIb3DQEJARYR cWFmaXZlQHR1Y293cy5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIB AQDpKz48gJG4ImyJi76kH3AdDZoGNZCC8xgWBUDk4yNXPqe3NxJvZooZIoctP2o8 CX6+xoK8p6jMb9iIz7ZVC9LuoUmoYZZWdoatMUwaz3xIa4Fq7HeLtCE3misKMcZq +QomhLFv2yMSgyzWWitHdW5oVDuT83Xs8FTZG33rI8gut1J9+5fhJV4WKuncfLwM xMrj+5iWm+KwoE86dTarGAPwYhC2FepcblszVbz87Dp1clTJLaN4potMES83RHo1 teHHmJAilNzy2PfRoylbzlQ38x1n10wbhqjMcoDYk6CSB40PlduqbsMjpkOClwu4 H92c2Hmo3bqRGWM2K5SXkj29AgMBAAGgADANBgkqhkiG9w0BAQQFAAOCAQEAKUh6 WH4WtC/LtlJhj+p5i3sLEG/L//8DQh30eOxwMxrSGGZUGTfLBT4RaeDA5JEIF5pK v4MxvDw1+NExMQW3h/9eVWXpGGjvC2EoLgya3ri3OJlQNOyqSzOvNunk0EPaWoO+ v9o2yKdH88e7NQZp8Pw5jhE9RV9u3+mNw2sztqpzcXYDXW3kKI2UiIP3eur2/iiH nSAIRl5NfUPgAzCem/zpM1lc3s+EVKysn2wF4bwOkNyYPo4DmgHCb7ggSQyhh5vN UAoDkyqu2ZScDZTyDG7YOdobMqwbsCT5er5Bq+NWOZyUE+3zO/1VQpznJehaGLrQ N7UAJliUAO+SFFGdxQ== -----END CERTIFICATE REQUEST-----",
  upgrade_options: "sitelock_enterprise",
  start_date: "2012-04-11T19:00:00.000-05:00"
}


GET_PRODUCT_INFO_HASH = {
  product_type: "truebizid_wildcard",
  issue_date: "2010-09-14-04:00",
  domain: "www.mail.ru",
  product_id: "23",
  contact_email: "qafive@example.com",
  start_date: "2010-09-13-04:00",
  expiry_date: "2010-09-22-04:00",
  is_renewable: "0",
  state: "expired"
}


GET_ORDER_INFO_HASH = {
 owner: CLIENT_CONTACT,
 admin: CLIENT_CONTACT,
 billing: CLIENT_CONTACT,
 tech: CLIENT_CONTACT,
 comments: "",
 reg_domain: "",
 domain: "",
 transfer_notes: [{timestamp: "05-OCT-2007 17:07:42", note: "Transfer Request message sent to owner@example.com"}],
 affiliate_id: "",
 order_date: "1083590189",
 status: "completed",
 f_lock_domain: "0",
 forwarding_email: "",
 flag_saved_ns_fields: "1",
 processed_date: "",
 id: "3515690",
 encoding_type: "undef",
 flag_saved_tech_fields: "1",
 completed_date: "1083590192",
 f_auto_renew: "Y",
 fqdn1: "ns1.systemdns.com",
 fqdn2: "ns2.systemdns.com",
 fqdn3: "",
 fqdn4: "",
 fqdn5: "",
 fqdn6: "",
 reg_type: "new",
 notes: [{note: "RSP Note: testing first note", timestamp: "27-OCT-2007 11:15:03"},{note: "RSP Note: testing first note", timestamp: "27-OCT-2007 11:15:03"}],
 master_order_id: "0",
 period: "1",
 cost: "15"
}


# empty class for client class SslProxy
class SslProxy
  # empty
end

class SRSClient < SslProxy
    attr :request, :username, :signature, :response

    # authenticate function
    def authenticate?
      # code for authentication
      false
      true
    end

    def initialize(request, username, signature)
      @request, @username, @signature = request, username, signature
      @response =  ApiCommand.new(request)
    end

    def response
      @response.response
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
    request.xpath('//OPS_envelope/body/data_block/dt_assoc/item').each do |item|
      rh[item['key']] = item.content unless item['key'] == "attributes"
    end
    request.xpath('//OPS_envelope/body/data_block/dt_assoc/item/dt_assoc/item').each do |item|
      rh[item['key']] = item.content
    end
    rh
  end

  def request_hash_simplexml
    XmlSimple.xml_in(xml, 'force_array' => ['item'], 'group_tags' => {'dt_assoc' => 'item'}, 'KeyAttr' => 'item')
    #{ 'KeyAttr' => 'name' }
  end

  def request_hash_rexml
    #getorderinfo = GetOrderInfo.new("12343")
    doc = REXML::Document.new xml
    h = {}
    doc.elements.each("//dt_assoc/item") { |element| h[element.attributes['key']] = element.text}
    h
  end

end



class ApiCommand
  attr :request_hash, :object, :action

  H_ACTION = 'action'
  H_OBJECT = 'object'

  GET_ORDER_INFO = "GET_ORDER_INFO"
  GET_PRODUCT_INFO = "GET_PRODUCT_INFO"


  SRS_ACTION = "action"
  SRS_OBJECT = "object"
  SRS_REG_TYPE = "reg_type"
  SRS_ORDER_ID = "order_id"
  SRS_PRODUCT_ID = "product_id"
  SRS_PRODUCT_TYPE = "product_type"
  SRS_DOMAIN = "domain"
  SRS_CSR = "csr"
  SRS_INVENTORY_ITEM_ID = "inventory_item_id"
  SRS_ALL_INFO = "all_info"


  class AttributeHash < Struct

    ATTRIBUTE_HASH_DOMAIN = {
      GET_ORDER_INFO => [
        SRS_ACTION, SRS_ORDER_ID
      ],
      GET_PRODUCT_INFO => [
        SRS_ACTION
      ]
    }

    ATTRIBUTE_HASH_SERVICE = {
      GET_ORDER_INFO => [
        SRS_ACTION
      ],
      GET_PRODUCT_INFO => [
        SRS_ACTION, SRS_PRODUCT_ID, SRS_ALL_INFO
      ]
    }


    def attr_value(ch)
      cc = {}
      ch.each do |command|
        cc[command] = request_hash[command]
      end
      cc
    end

    def domain
      request_parameters = attr_value(ATTRIBUTE_HASH_DOMAIN[request_hash[H_ACTION]])
      ActionH.new(request_parameters).response
    end

    def trust_service
      request_parameters = attr_value(ATTRIBUTE_HASH_SERVICE[request_hash[H_ACTION]])
      ActionHService.new(request_parameters).response
    end
  end

  #For Domain Request
  class ActionHash < Struct

    QUERY_APPROVER_LIST_RESPONSE = "approver_list_response"
    RESEND_APPROVE_EMAIL_RESPONSE = "resend_approve_email"
    RESEND_CERT_EMAIL_RESPONSE = "resend_certificate_email"
    GET_ORDER_INFO_RESPONSE = "order_info_response"
    GET_PRODUCT_INFO_RESPONSE = "product_info_response"

    def action
      attributes['action'].downcase
    end

    def response
      self.send(action)
    end

    def get_order_info
      r = {}
      #attributes
      ##client_function(attributes)
      r[:layout], r[:data] = GET_ORDER_INFO_RESPONSE, GET_ORDER_INFO_HASH
      r
    end

    def get_product_info
      #attributes
      ##client_function(attributes)
    end
  end


  #For Service Request
  class ActionHashService < Struct

    QUERY_APPROVER_LIST_RESPONSE = "approver_list_response"
    RESEND_APPROVE_EMAIL_RESPONSE = "resend_approve_email"
    RESEND_CERT_EMAIL_RESPONSE = "resend_certificate_email"
    GET_ORDER_INFO_RESPONSE = "order_info_response"
    GET_PRODUCT_INFO_RESPONSE = "product_info_response"
    GET_PRODUCT_INFO_ALL_RESPONSE = "product_info_all_response"

    class GPIInfo
     attr :attributes
     def initialize(attributes)
       @attributes = attributes
     end

     def response
       #attributes
       ##client_function(attributes)
       return GET_PRODUCT_INFO_RESPONSE, GET_PRODUCT_INFO_HASH
     end
    end

    class GPIAll
      attr :attributes
     def initialize(attributes)
       @attributes = attributes
     end

     def response
       #attributes
       ##client_function(attributes)
       return GET_PRODUCT_INFO_ALL_RESPONSE, GET_PRODUCT_INFO_ALL_HASH
     end
    end

    class GPIResponse
      attr :attributes
      def self.all_info
        @attributes['all_info']
      end

      def initialize(attributes)
        @attributes = attributes
      end

      def self.create(attributes)
        @attributes = attributes
        case all_info
          when nil
            return GPIInfo.new(attributes)
          when "1"
            return GPIAll.new(attributes)
        end
      end
    end


    def action
      attributes['action'].downcase
    end

    def response
      self.send(action)
    end

    def get_order_info
      #attributes
      ##client_function(attributes)
    end

    def get_product_info
      r = {}
      gpi = GPIResponse.create(attributes)
      r[:layout], r[:data] = gpi.response
      r
    end
  end



  AttrH = AttributeHash.new(:request_hash)
  ActionH = ActionHash.new(:attributes)
  ActionHService = ActionHashService.new(:attributes)

  def initialize(request_hash)
    @request_hash = request_hash
    @object = request_hash[H_OBJECT].downcase
    @action = request_hash[H_ACTION].downcase
  end

  def response
    attribute_hash = AttrH.new(@request_hash)
    attribute_hash.send(@object)
  end

end


class Opensrs2Controller < ApplicationController
  respond_to :xml, :only => :index

  SIGNATURE = "X-Signature"
  USERNAME = "X-Username"

  def index
    username = request.headers[USERNAME]
    signature = request.headers[SIGNATURE]

    body_xml = request.body.read

    request_hash = OpenSRSRequestParse.new(body_xml).request_hash_rexml
    opensrs = SRSClient.new(request_hash,username,signature)

    if opensrs.authenticate?
      response_hash = opensrs.response
      @data = response_hash[:data]
      render "layouts/#{response_hash[:layout]}", :formats => [:xml]
    else
      render "layouts/bad_authorization", :formats => [:xml]
    end
  end
end