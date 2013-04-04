require 'nokogiri'
#require 'opensrs'
require 'xmlsimple'
require "rexml/document"



GET_ORDER_INFO_HASH = {
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


  SRS_ORDER_ID = "order_id"
  SRS_ACTION = "action"


  class AttributeHash < Struct

    ATTRIBUTE_HASH_DOMAIN = {
      GET_ORDER_INFO => [
        SRS_ORDER_ID, SRS_ACTION
      ],
      GET_PRODUCT_INFO => [
        SRS_ORDER_ID, SRS_ACTION
      ]
    }

    ATTRIBUTE_HASH_SERVICE = {
      GET_ORDER_INFO => [
        SRS_ACTION
      ],
      GET_PRODUCT_INFO => [
        SRS_ACTION
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
      #
      #r = {}
      ##attributes
      ###client_function(attributes)
      #r[:layout], r[:data] = GET_PRODUCT_INFO_RESPONSE, GET_ORDER_INFO_HASH
      #r
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
