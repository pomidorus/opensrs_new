#require 'nokogiri'
#require 'opensrs'
#require 'xmlsimple'
require "rexml/document"


SWREGISTER_NEW_DOMAIN_HASH = {
  admin_email: "jsmith@example.com",
  whois_privacy_state: "enabled",
  registration_text: "Domain registration successfully completed. WHOIS Privacy successfully enabled. Domain successfully locked.",
  registration_code: "200",
  id: "3735281",
  cancelled_orders: ["3764860","3764861"]
}


SWREGISTER_NEW_SERVICE_HASH = {
  domain: "google.com",
  order_id: "5555",
  state: "awaiting-approval"
}


CANCEL_ORDER_HASH = {
   domain_name: "example.ru",
   order_id: "5555",
   state: "declined"
 }.freeze


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
}.freeze


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
}.freeze


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


QUERY_APPROVER_LIST_HASH = {
  approver_list: [
    {email: "qafive@example.com", domain: "example.com", type: "MANUAL"},
    {email: "ottway@example.com", domain: "example.com", type: "MANUAL"},
    {email: "qafive@example.com", domain: "example.com", type: "MANUAL"},
    {email: "admin@example.com", domain: "example.com", type: "MANUAL"},
    {email: "qafive@example.com", domain: "example.com", type: "MANUAL"}
  ]
}

RESEND_APPROVE_EMAIL_HASH = {
  order_id: "1111"
}

RESEND_CERT_EMAIL_HASH = {
  order_id: "1111"
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


PARSE_CSR_HASH = {
  :country => 'RU',
  :organization_unit => 'IT',
  :valid_true_domain => true,
  :state => 'Moscow',
  :locality => 'Moscow locality',
  :email => 'info@example.ru',
  :domain_name => 'example.ru',
  :valid_quick_domain => true,
  :has_bad_extensions => false,
  :organization => 'ZAO Example',
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

  #def request_hash
  #  request = Nokogiri::XML(xml)
  #  rh = {}
  #  request.xpath('//OPS_envelope/body/data_block/dt_assoc/item').each do |item|
  #    rh[item['key']] = item.content unless item['key'] == "attributes"
  #  end
  #  request.xpath('//OPS_envelope/body/data_block/dt_assoc/item/dt_assoc/item').each do |item|
  #    rh[item['key']] = item.content
  #  end
  #  rh
  #end

  #def request_hash_simplexml
  #  XmlSimple.xml_in(xml, 'force_array' => ['item'], 'group_tags' => {'dt_assoc' => 'item'}, 'KeyAttr' => 'item')
  #  #{ 'KeyAttr' => 'name' }
  #end

  def request_hash_rexml
    doc = REXML::Document.new xml
    h = {}
    doc.elements.each("//dt_assoc/item") { |element| h[element.attributes['key']] = element.text}
    p "---------"
    p h
    test = {}
    doc.elements.each('//dt_assoc/item[@key = "contact_set"]/dt_assoc/item') do |element|
      contact = {}
      element.elements.each("./dt_assoc/item") {|e| contact[e.attributes['key']] = e.text}
      test[element.attributes['key']] = contact
    end
    p "-----------"
    p test
    h["contact_set"] = test
    h
  end

end



class ApiCommand
  attr :request_hash, :object, :action

  H_ACTION = 'action'
  H_OBJECT = 'object'

  GET_ORDER_INFO = "GET_ORDER_INFO"
  GET_PRODUCT_INFO = "GET_PRODUCT_INFO"
  QUERY_APPROVER_LIST = "QUERY_APPROVER_LIST"
  RESEND_APPROVE_EMAIL = "RESEND_APPROVE_EMAIL"
  RESEND_CERT_EMAIL = "RESEND_CERT_EMAIL"
  SW_REGISTER = "SW_REGISTER"
  CANCEL_ORDER = "CANCEL_ORDER"
  PARSE_CSR = "PARSE_CSR"

  SRS_ACTION = "action"
  SRS_OBJECT = "object"
  SRS_ORDER_ID = "order_id"
  SRS_PRODUCT_ID = "product_id"
  SRS_PRODUCT_TYPE = "product_type"
  SRS_DOMAIN = "domain"
  SRS_CSR = "csr"
  SRS_INVENTORY_ITEM_ID = "inventory_item_id"
  SRS_ALL_INFO = "all_info"

  SRS_REG_TYPE = "reg_type"
  SRS_REGISTRANT_IP = "registrant_ip"
  SRS_CONTACT_SET = "contact_set"
  SRS_CUSTOM_NAMESERVERS = "custom_nameservers"
  SRS_REG_PASSWORD = "reg_password"
  SRS_REG_USERNAME = "reg_username"
  SRS_CUSTOM_TECH_CONTACT = "custom_tech_contact"
  SRS_HANDLE = "handle"

  SRS_APPROVER_EMAIL = "approver_email"
  SRS_SPECIAL_INSTRUCTIONS = "special_instructions"
  SRS_PERIOD = "period"
  SRS_SERVER_TYPE = "server_type"

  class AttributeHash < Struct

    ATTRIBUTE_HASH_DOMAIN = {
      GET_ORDER_INFO => [
        SRS_ACTION, SRS_ORDER_ID
      ],
      GET_PRODUCT_INFO => [
        SRS_ACTION
      ],
      SW_REGISTER => [
        SRS_ACTION, SRS_REGISTRANT_IP, SRS_ORDER_ID, SRS_CONTACT_SET,
        SRS_CUSTOM_NAMESERVERS, SRS_REG_TYPE, SRS_REG_PASSWORD, SRS_REG_USERNAME,
        SRS_DOMAIN, SRS_CUSTOM_TECH_CONTACT
      ]
    }

    ATTRIBUTE_HASH_SERVICE = {
      GET_ORDER_INFO => [
        SRS_ACTION
      ],
      GET_PRODUCT_INFO => [
        SRS_ACTION, SRS_PRODUCT_ID, SRS_ALL_INFO
      ],
      QUERY_APPROVER_LIST => [
        SRS_ACTION, SRS_DOMAIN, SRS_PRODUCT_TYPE
      ],
      RESEND_APPROVE_EMAIL => [
        SRS_ACTION, SRS_ORDER_ID
      ],
      RESEND_CERT_EMAIL => [
        SRS_ACTION, SRS_ORDER_ID
      ],
      CANCEL_ORDER => [
        SRS_ACTION, SRS_ORDER_ID
      ],
      PARSE_CSR => [
        SRS_ACTION, SRS_CSR, SRS_PRODUCT_TYPE
      ],
      SW_REGISTER => [
        SRS_ACTION, SRS_REGISTRANT_IP, SRS_REG_TYPE, SRS_PRODUCT_TYPE,
        SRS_CONTACT_SET, SRS_HANDLE, SRS_APPROVER_EMAIL, SRS_SPECIAL_INSTRUCTIONS,
        SRS_PERIOD, SRS_SERVER_TYPE, SRS_DOMAIN, SRS_PRODUCT_ID
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

    def reg_type
      attributes['reg_type'].downcase
    end

    def sw_register
      r = {}
      p attributes
      swregister = SWRegDomain.new(attributes)
      r[:layout], r[:data] = swregister.send(reg_type)
      r
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
    CANCEL_ORDER_RESPONSE = "cancel_order_response"
    PARSE_CSR_RESPONSE = "parse_csr_response"

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

    def query_approver_list
      r = {}
      #attributes
      ##client_function(attributes)
      r[:layout], r[:data] = QUERY_APPROVER_LIST_RESPONSE, QUERY_APPROVER_LIST_HASH
      r
    end

    def resend_approve_email
      r = {}
      #attributes
      ##client_function(attributes)
      r[:layout], r[:data] = RESEND_APPROVE_EMAIL_RESPONSE, RESEND_APPROVE_EMAIL_HASH
      r
    end

    def resend_cert_email
      r = {}
      #attributes
      ##client_function(attributes)
      r[:layout], r[:data] = RESEND_CERT_EMAIL_RESPONSE, RESEND_CERT_EMAIL_HASH
      r
    end

    def cancel_order
      r = {}
      #attributes
      ##client_function(attributes)
      r[:layout], r[:data] = CANCEL_ORDER_RESPONSE, CANCEL_ORDER_HASH
      r
    end

    #Parses the CSR and identifies its data elements.
    def parse_csr
      r = {}
      #attributes
      ##client_function(attributes)
      r[:layout], r[:data] = PARSE_CSR_RESPONSE, PARSE_CSR_HASH
      r
    end

    def reg_type
      attributes['reg_type'].downcase
    end

    #Submits a new domain registration or Trust Service request or transfer order that obeys the Reseller's 'process immediately' flag setting
    def sw_register
      r = {}
      p attributes
      swregister = SWRegService.new(attributes)
      r[:layout], r[:data] = swregister.send(reg_type)
      r
    end

  end


  AttrH = AttributeHash.new(:request_hash)
  ActionH = ActionHash.new(:attributes)
  ActionHService = ActionHashService.new(:attributes)

  #-------------------------------------------------------

  class SWRegisterDomain < Struct
    SWREGISTER_NEW_RESPONSE = "sw_register_new_domain_response"

    def new
      #attributes
      ##client_function(attributes)
      return SWREGISTER_NEW_RESPONSE, SWREGISTER_NEW_DOMAIN_HASH
    end
  end

  class SWRegisterService < Struct
    SWREGISTER_NEW_RESPONSE = "sw_register_new_service_response"
    SWREGISTER_RENEW_RESPONSE = "sw_register_renew_service_response"

    def new
      #attributes
      ##client_function(attributes)
      return SWREGISTER_NEW_RESPONSE, SWREGISTER_NEW_SERVICE_HASH
    end

    def renew
      #attributes
      ##client_function(attributes)
      return SWREGISTER_NEW_RESPONSE, SWREGISTER_NEW_SERVICE_HASH
    end

  end


  SWRegDomain = SWRegisterDomain.new(:attributes)
  SWRegService = SWRegisterService.new(:attributes)

  #-------------------------------------------------------

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
