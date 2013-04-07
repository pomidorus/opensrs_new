#class SRSCommand < Struct
#  def say
#    "hello"
#  end
#end
#
#GetOrderInfo = SRSCommand.new(:order_id)
#
#getorderinfo = GetOrderInfo.new("12343")
#p getorderinfo.say
#p getorderinfo.order_id
#
#GetProductInfo = SRSCommand.new(:product_id)
#getpinfo = GetProductInfo.new("12343")
#p getpinfo.say
#p getpinfo.product_id


GET_ORDER_INFO_RESPONSE = {
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



class ApiCommand2
  attr :request_hash, :object, :action

  H_ACTION = 'action'
  H_OBJECT = 'object'

  GET_ORDER_INFO = "GET_ORDER_INFO"
  GET_PRODUCT_INFO = "GET_PRODUCT_INFO"


  SRS_ORDER_ID = "order_id"
  SRS_ACTION = "action"

  QUERY_APPROVER_LIST_RESPONSE = "approver_list_response"
  RESEND_APPROVE_EMAIL_RESPONSE = "resend_approve_email"
  RESEND_CERT_EMAIL_RESPONSE = "resend_certificate_email"
  GET_ORDER_INFO_RESPONSE = "order_info_response"
  GET_PRODUCT_INFO_RESPONSE = "product_info_response"


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



  class AttributeHash < Struct

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
      ATTRIBUTE_HASH_SERVICE[request_hash[H_ACTION]]
    end
  end

  class ActionHash < Struct

    def action
      attributes['action'].downcase
    end

    def response
      self.send(action)
    end

    def get_order_info
      #attributes['order_id']
      ##client_function(order_id)
      ##response client function
      #GET_ORDER_INFO_RESPONSE
      "get_order_info"

      return {:layout => "test", :data => {test: "test"}}
    end

    def get_product_info
      "get_product_info"
    end
  end

  AttrH = AttributeHash.new(:request_hash)
  ActionH = ActionHash.new(:attributes)

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

puts ApiCommand.new({"protocol"=>"XCP", "action"=>"GET_ORDER_INFO", "object"=>"DOMAIN", "attributes"=>"\n          ", "order_id"=>"123746"}).response
#puts ApiCommand.new({"protocol"=>"XCP", "action"=>"GET_ORDER_INFO", "object"=>"TRUST_SERVICE", "attributes"=>"\n          ", "order_id"=>"123746", "test"=>"lolo", "tro"=>"\n              ", "dfdf"=>"\n                  ", "d"=>"d", "f"=>"d", "sdsd"=>"\n                  ", "dd"=>"d", "ff"=>"d"}).create

#puts ApiCommand.new({"protocol"=>"XCP", "action"=>"GET_PRODUCT_INFO", "object"=>"DOMAIN", "attributes"=>"\n          ", "order_id"=>"123746", "test"=>"lolo", "tro"=>"\n              ", "dfdf"=>"\n                  ", "d"=>"d", "f"=>"d", "sdsd"=>"\n                  ", "dd"=>"d", "ff"=>"d"}).create
#puts ApiCommand.new({"protocol"=>"XCP", "action"=>"GET_PRODUCT_INFO", "object"=>"TRUST_SERVICE", "attributes"=>"\n          ", "order_id"=>"123746", "test"=>"lolo", "tro"=>"\n              ", "dfdf"=>"\n                  ", "d"=>"d", "f"=>"d", "sdsd"=>"\n                  ", "dd"=>"d", "ff"=>"d"}).create
