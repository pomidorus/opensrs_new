require 'nokogiri'
#require 'opensrs'

# empty class for client class SslProxy
class SslProxy
  # empty
end

class OpenSRSClient < SslProxy
    attr :request, :username, :signature, :response

    # authenticate function
    def authenticate?
      # code for authentication
      false
      true
    end

    def initialize(request, username, signature)
      @request, @username, @signature = request, username, signature
      @response =  OpenSRSResponse.new(request)
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
    Rails.logger.debug request.inspect

    request.xpath('//OPS_envelope/body/data_block/dt_assoc/item').each do |item|
      rh[item['key']] = item.content unless item['key'] == "attributes"
    end
    request.xpath('//OPS_envelope/body/data_block/dt_assoc/item/dt_assoc/item').each do |item|
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
  SRS_ORDER_ID = "order_id"
  SRS_PRODUCT_ID = "product_id"
  SRS_PRODUCT_TYPE = "product_type"
  SRS_DOMAIN = "domain"
  SRS_CSR = "csr"
  SRS_INVENTORY_ITEM_ID = "inventory_item_id"

  GET_ORDER_INFO = "GET_ORDER_INFO"
  GET_PRODUCT_INFO = "GET_PRODUCT_INFO"
  QUERY_APPROVER_LIST = "QUERY_APPROVER_LIST"
  RESEND_APPROVE_EMAIL = "RESEND_APPROVE_EMAIL"
  RESEND_CERT_EMAIL = "RESEND_CERT_EMAIL"
  SW_REGISTER = "SW_REGISTER"
  CANCEL_ORDER = "CANCEL_ORDER"
  PARSE_CSR = "PARSE_CSR"

  QUERY_APPROVER_LIST_RESPONSE = "approver_list_response"
  RESEND_APPROVE_EMAIL_RESPONSE = "resend_approve_email"
  RESEND_CERT_EMAIL_RESPONSE = "resend_certificate_email"
  GET_ORDER_INFO_RESPONSE = "order_info_response"
  GET_PRODUCT_INFO_RESPONSE = "product_info_response"


  ACTION_RESPONSE = {
    GET_ORDER_INFO => GET_ORDER_INFO_RESPONSE,
    GET_PRODUCT_INFO => GET_PRODUCT_INFO_RESPONSE,
    QUERY_APPROVER_LIST => QUERY_APPROVER_LIST_RESPONSE,
    RESEND_APPROVE_EMAIL => RESEND_APPROVE_EMAIL_RESPONSE,
    RESEND_CERT_EMAIL => RESEND_CERT_EMAIL_RESPONSE
  }

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

  def domain
    request_hash[SRS_DOMAIN]
  end

  def product_type
    request_hash[SRS_PRODUCT_TYPE]
  end

  def order_id
    request_hash[SRS_ORDER_ID]
  end

  def inventory_item_id
    request_hash[SRS_INVENTORY_ITEM_ID]
  end

  def product_id
    request_hash[SRS_PRODUCT_ID]
  end

  def crs
    @request_hash[SRS_CSR]
  end


  def parse_csr(product_type, csr)
    #client_function(product_type, csr)
    #response client function
    {
      domain_name: 'example.ru',
      country: 'RU',
      email: '',
      locality: 'Moscow',
      organization: 'ZAO Example',
      organization_unit: 'IT',
      state: 'Moscow',
      valid_true_domain: true,
      valid_quick_domain: true,
      has_bad_extensions: false
    }
  end


  def cancel_order(order_id)
   {
      domain_name: "example.ru",
      order_id: "5555",
      state: "Moscow"
    }
  end


  def approver_list(domain, product_type)
    #client_function(domain, product_type)
    #response client function
    {
      approver_list: [
        {email: "qafive@example.com", domain: "example.com", type: "MANUAL"},
        {email: "ottway@example.com", domain: "example.com", type: "MANUAL"},
        {email: "qafive@example.com", domain: "example.com", type: "MANUAL"},
        {email: "admin@example.com", domain: "example.com", type: "MANUAL"},
        {email: "qafive@example.com", domain: "example.com", type: "MANUAL"}
      ]
    }
  end

  def resend_approve_email(order_id)
    #client_function(order_id)
    #response client function
    {
      order_id: "1111"
    }
  end

  def resend_cert_email(order_id)
    #client_function(order_id)
    #response client function
    {
      order_id: "2222"
    }
  end

  def product_info(product_id)
    #client_function(product_id)
    #response client function
    {
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
  end

  def order_info(order_id)
    #client_function(order_id)
    #response client function
    {
     owner: {
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
            },
     admin: {
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
            },
     billing: {
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
              },
     tech: {
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
           },
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
  end


  def register_ssl_hash
   {
      domain_name: 'example.ru',
      order_id: "3333",
      state: 'completed',
      product_type: 'truebizid',
      product_id: 194,
      contact_email: 'qafive@example.com',
      csr: '-----BEGIN CERTIFICATE REQUEST----- MIIC2jCCAcICAQAwgZQxITAfBgNVBAMTGHRydWViaXoucWFyZWdyZXNzaW9uLm9y ZzELMAkGA1UEBhMCQ0ExCzAJBgNVBAgTAk9OMRAwDgYDVQQHEwdUb3JvbnRvMQ 8w DQYDVQQKEwZUdWNvd3MxEDAOBgNVBAsTB1FBIERlcHQxIDAeBgkqhkiG9w0BCQE WEXFhZml2ZUB0dWNvd3MuY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC AQEAo+4AzMq3JeXV5KlAD3BBOGdAOuJYBW3Bz1BooLPX4MGefxqzfVcR8KLGg5MS PLqdiY4Sqc+/tK8qabpHttdbAZ1WBvgYmviMkhRjpSrbVjOca0CmydPCVsXu5nnE HMEZODrzhpuHHIzrkclBpGAqEhf9v1g4OFt1sInVB0o8NpeT10aFyvX2HbtsJyfZ S4RMsP+XjVWzWZ+8v2bH6gapJ0tzXvTKwXzhUzElvVqpldpzO0FgnJtHmfJ/EOs5 gntzVIxzP12ZKFf0dYYUj0OKWU+aQodlic2oVxETyWKCoX5W7jQgpTV/vAF7nQY8 Y9VtV6SE5yQRYPJutDTk2PouEwIDAQABoAAwDQYJKoZIhvcNAQEEBQADggEBAAUr DUNxyrYpt3t9r0GCIiIDVyQdJvY4tQUFIEJdxcvRo2TUcrgiWPyntGc1OCtUFE9Z 2JX4BNEmFVN1jUdBzh6/0loAA36iGYWTSB6CPVe5+y+dcgbViWcNV4or7FOslzRH /Eu0CquMGmGtSdaT/DNIrJvM2iGOtuhFBhFyru61YMoeaQLU12i5XvK7bR4wHrG6 8DwlwUdzBRqiaq32rM/ZF2KmMzfLFKug1Hubt3OBQHSKwXz3CR7hrJSzf1q3lF/w HD47TC982HXaUuskI+E0LcuR/qprLkvAO6hKT60CP+V/yNwcBu79Zjeg1MsAmH/W SzFmc1swYutlFBxmyLU= -----END CERTIFICATE REQUEST-----',
      reg_type: 'new',
      price: 99.0,
      server_type: 'apachessl',
      supplier_order_id: 141777,
      special_instructions: 'Test ABC',
      period: 1,
      notes_list: [
        {date: '2010-09-20T15:02:43.000- 04:00', type: 'order_processed', note: 'Order id [780] has been processed, supplierOrderId is [141777].'},
        {date: '2010-09-20T15:02:43.000- 04:00', type: 'order_processed', note: 'Order id [780] has been processed, supplierOrderId is [141777].'}
      ],
      contact_set:
        {
          :admin =>
            {
              :first_name => 'Adler',
              :last_name => 'Adams',
              :title => 'Director',
              :address1 => '32 Oak Street',
              :address2 => 'Suite 100',
              :address3 => nil,
              :city => 'Santa Clara',
              :state => 'CA',
              :country => 'US',
              :postal_code => 90210,
              :org_name => 'Example Inc.',
              :email => 'adams@example.com',
              :phone => '+1.4165550123x1812',
              :fax => '+1.4165550125'
            },
          :tech =>
            {
              :first_name => 'Tim',
              :last_name => 'Tucker',
              :title => 'Director',
              :org_name => 'Example Inc.',
              :address1 => '32 Oak Street',
              :address2 => 'Suite 100',
              :address3 => nil,
              :city => 'Santa Clara',
              :state => 'CA',
              :country => 'US',
              :postal_code => 90210,
              :phone => '+1.4165550123x1243',
              :fax => '+1.41655501255',
              :email => 'tucker@example.com'
            },
          :organization =>
            {
              :org_name => 'Example Inc.',
              :duns => 12345,
              :address1 => '32 Oak Street',
              :address2 => 'Suite 100',
              :address3 => nil,
              :city => 'Santa Clara',
              :state => 'CA',
              :postal_code => 90210,
              :country => 'US',
              :phone => '+1.4165550123',
              :fax => '+1.4165550125'
            },
          :billing =>
            {
              :first_name => 'Bill',
              :last_name => 'Burton',
              :org_name => 'Example Inc.',
              :title => nil,
              :address1 => '32 Oak Street',
              :address2 => 'Suite 100',
              :address3 => nil,
              :city => 'Santa Clara',
              :state => 'CA',
              :postal_code => '90210',
              :country => 'US',
              :phone => '+1.4165550123x1248',
              :fax => '+1.4165550125',
              :email => 'burton@example.com',
            }
        }
    }
  end

  def register_ssl(order_id)
    return register_ssl_hash, "register_ssl_cert_response"
  end

  def response
    result = {}

    case action
    when GET_ORDER_INFO
      result[:data], result[:layout] = order_info(order_id), ACTION_RESPONSE[GET_ORDER_INFO]

    when GET_PRODUCT_INFO
      result[:data], result[:layout] = product_info(product_id), ACTION_RESPONSE[GET_PRODUCT_INFO]

    when QUERY_APPROVER_LIST
      result[:data], result[:layout] = approver_list(domain, product_type), ACTION_RESPONSE[QUERY_APPROVER_LIST]

    when RESEND_APPROVE_EMAIL
      result[:data], result[:layout] = resend_approve_email(order_id), ACTION_RESPONSE[RESEND_APPROVE_EMAIL]

    when RESEND_CERT_EMAIL
      result[:data], result[:layout] = resend_cert_email(order_id), ACTION_RESPONSE[RESEND_CERT_EMAIL]

    when SW_REGISTER
      result[:data], result[:layout] = register_ssl(order_id)

    when CANCEL_ORDER
        result[:data], result[:layout] = cancel_order(order_id), "cancel_order_response"

    when PARSE_CSR
        result[:data], result[:layout] = parse_csr(product_type, crs), "parse_csr_response"
    end

    result
  end

end

class OpensrsController < ApplicationController
  respond_to :xml, :only => :index

  SIGNATURE = "X-Signature"
  USERNAME = "X-Username"

  def index
    username = request.headers[USERNAME]
    signature = request.headers[SIGNATURE]

    opensrs_request_hash = OpenSRSRequestParse.new(request.body.read).request_hash
    opensrs = OpenSRSClient.new(opensrs_request_hash,username,signature)

    if opensrs.authenticate?
      response_hash = opensrs.response
      @data = response_hash[:data]
      Rails.logger.debug @data
      render "layouts/#{response_hash[:layout]}", :formats => [:xml]
    else
      render "layouts/bad_authorization", :formats => [:xml]
    end
  end
end

