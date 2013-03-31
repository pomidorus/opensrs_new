require 'opensrs'


class OpenSRSRequest
  attr :server, :username, :password, :key

  def initialize(server,username,password,key)
    OpenSRS::Server.xml_processor = :nokogiri
    @server, @username, @password, @key = server, username, password, key
  end

  # init remote server
  def remote_server
    OpenSRS::Server.new(
      :server   => server,
      :username => username,
      :password => password,
      :key      => key
    )
  end

  # request api with parameters
  def request_api(action,object,attributes)
    remote_server.call(
          :action => action,
          :object => object,
          :attributes => attributes
        )
  end

end


opensrs_request = OpenSRSRequest.new("http://localhost:3000/opensrs","aseleznov","53cr3t","c633be3170c7fb3fb29e2f99b84be2410")
#opensrs_request = OpenSRSRequest.new("http://opensrs.herokuapp.com/opensrs","aseleznov","53cr3t","c633be3170c7fb3fb29e2f99b84be2410")

#getOrderInfo
#getOrderInfo = {action: "GET_ORDER_INFO", object: "DOMAIN", order_id: "1234"}
#getProductInfo = {action: "GET_PRODUCT_INFO", object: "TRUST_SERVICE", product_id: "1234"}
#approverList = {action: "QUERY_APPROVER_LIST", object: "TRUST_SERVICE", domain: "www.mail.ru", product_type: "quickssl"}
#resendApprEmail = {action: "RESEND_APPROVE_EMAIL", object: "TRUST_SERVICE", order_id: "123432"}
#resendSertEmail = {action: "RESEND_CERT_EMAIL", object: "TRUST_SERVICE", order_id: "123432"}
#cancelSSL = {action: "CANCEL_ORDER", object: "TRUST_SERVICE", order_id: "123432"}
#
#sslcert = %q(-----BEGIN CERTIFICATE REQUEST----- MIIBqTCCARICAQAwaTELMAkGA1UEBhMCQ0ExCzAJBgNVBAgTAm9uMRAwDgYDVQQH
#Ewd0b3JvbnRvMQ8wDQYDVQQKEwZ0dWNvd3MxCzAJBgNVBAsTAnFhMR0wGwYDVQQD
#ExR3d3cucWFyZWdyZXNzaW9uLm9yZzCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkC
#gYEAz+hbqqnE5BSW0THf7txxsJxF8Vtca2uL52iutI1SRTm9J6NNtAjgMbL9upOm
#SFnObpWKriUIlvxKrecygGWkjiMeyU/F6auAS9/vwDdxYEVT2szK+Q2At1FgU433
#Pds53v2J/vyB6SL+k/w54H2gF4ORpU1hjUggo7fM353TeeMCAwEAAaAAMA0GCSqG
#SIb3DQEBBAUAA4GBAIYvVThVeocN7N7HbsO/au9AXnx6LULQ5LMDWx6FlyBB5g9h
#5HYZa6xieYCYDxYIsjLjR3qx1BWl9+0kSL2MW4EdDPzbcrZvHAtrw2/hPrm9EGA3
#2w3a26W79N3clCkrahnpcNFLFyzU3CtZASJ+VuixGXTEkdiBAliqtGp+QBhf -----END
#CERTIFICATE REQUEST-----)
#parseCRS = {action: "PARSE_CSR", object: "TRUST_SERVICE", product_type: "quickssl", csr: sslcert }
#
#registerSSL = {action: "SW_REGISTER", object: "TRUST_SERVICE", reg_type: "new", product_type: "quickssl"}
#renewSSL = {action: "SW_REGISTER", object: "TRUST_SERVICE", reg_type: "renew", product_id: "12"}
#renewSSL = {action: "SW_REGISTER", object: "TRUST_SERVICE", reg_type: "renew", order_id: "12"}
#renewSSL = {action: "SW_REGISTER", object: "TRUST_SERVICE", reg_type: "renew", inventory_item_id: "12"}


#action = "SW_REGISTER"
#object = "TRUST_SERVICE"
#attributes = { reg_type: 'upgrade' }
#api = opensrs_request.request_api(action,object,attributes)
#puts "---------RENEW_SSL-----------------------------------"
#puts api.request_xml
#puts api.response_xml


#action = "GET_ORDER_INFO"
#object = "DOMAIN"
#attributes = { order_id: '123746' }
#api = opensrs_request.request_api(action,object,attributes)
#puts "------GET_ORDER_INFO---------------------------------------"
#puts api.request_xml
#puts api.response_xml


#action = "GET_PRODUCT_INFO"
#object = "TRUST_SERVICE"
#attributes = { product_id: '123746' }
#api = opensrs_request.request_api(action,object,attributes)
#puts "------GET_PRODUCT_INFO---------------------------------------"
#puts api.request_xml
#puts api.response_xml


action = "QUERY_APPROVER_LIST"
object = "TRUST_SERVICE"
attributes = { domain: 'www.mail.ru', product_type: "quickssl" }
api = opensrs_request.request_api(action,object,attributes)
puts "------QUERY_APPROVER_LIST---------------------------------------"
puts api.request_xml
puts api.response_xml

#
#action = "RESEND_APPROVE_EMAIL"
#object = "TRUST_SERVICE"
#attributes = { order_id: '123432' }
#api = opensrs_request.request_api(action,object,attributes)
#puts "------RESEND_APPROVE_EMAIL---------------------------------------"
#puts api.request_xml
#puts api.response_xml
#
#
#action = "RESEND_CERT_EMAIL"
#object = "TRUST_SERVICE"
#attributes = { order_id: '12' }
#api = opensrs_request.request_api(action,object,attributes)
#puts "------RESEND_CERT_EMAIL---------------------------------------"
#puts api.request_xml
#puts api.response_xml




  #
  #def cancel_order(order_id)
  #  remote_server.call(
  #        :action => "CANCEL_ORDER",
  #        :object => "TRUST_SERVICE",
  #        :attributes => {
  #          :order_id => order_id
  #        }
  #      )
  #end
  #
  #def parse_csr(product_type, csr)
  #  remote_server.call(
  #        :action => "PARSE_CSR",
  #        :object => "TRUST_SERVICE",
  #        :attributes => {
  #          :product_type => product_type,
  #          :csr => csr
  #        }
  #      )
  #end
  #
  #def register_ssl_cert(order_id)
  #  remote_server.call(
  #        :action => "SW_REGISTER",
  #        :object => "TRUST_SERVICE",
  #        :attributes => {
  #          :order_id => order_id
  #        }
  #      )
  #end
  #
  #
  #def renew_ssl(attributes)
  #  remote_server.call(
  #    :action => "SW_REGISTER",
  #    :object => "TRUST_SERVICE",
  #    :attributes => attributes
  #  )
  #end
