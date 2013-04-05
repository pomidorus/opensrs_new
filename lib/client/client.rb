require 'opensrs'
require 'libxml'


class OpenSRSRequest
  attr :server, :username, :password, :key

  def initialize(server,username,password,key)
    OpenSRS::Server.xml_processor = :libxml
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

opensrs_request = OpenSRSRequest.new("http://localhost:3000/opensrs2","aseleznov","53cr3t","c633be3170c7fb3fb29e2f99b84be2410")
#opensrs_request = OpenSRSRequest.new("http://opensrs.herokuapp.com/opensrs","aseleznov","53cr3t","c633be3170c7fb3fb29e2f99b84be2410")

#For a .RU domain order
action = "GET_ORDER_INFO"
object = "DOMAIN"
attributes = { order_id: '123746'}
api = opensrs_request.request_api(action,object,attributes)
puts "------GET_ORDER_INFO---------------------------------------"
puts api.request_xml
puts api.response_xml
#
#

##Retrieves the properties for a Trust Service product.
action = "GET_PRODUCT_INFO"
object = "TRUST_SERVICE"
attributes = { product_id: '123746' }
api = opensrs_request.request_api(action,object,attributes)
puts "------GET_PRODUCT_INFO---------------------------------------"
puts api.request_xml
puts api.response_xml

##Retrieves all information for a Trust Service product.
action = "GET_PRODUCT_INFO"
object = "TRUST_SERVICE"
attributes = { product_id: '123746', all_info: 1 }
api = opensrs_request.request_api(action,object,attributes)
puts "------GET_PRODUCT_INFO_ALL---------------------------------------"
puts api.request_xml
puts api.response_xml
###
###

action = "QUERY_APPROVER_LIST"
object = "TRUST_SERVICE"
attributes = { domain: 'www.mail.ru', product_type: "quickssl" }
api = opensrs_request.request_api(action,object,attributes)
puts "------QUERY_APPROVER_LIST---------------------------------------"
puts api.request_xml
puts api.response_xml
##
##

action = "RESEND_APPROVE_EMAIL"
object = "TRUST_SERVICE"
attributes = { order_id: '123432' }
api = opensrs_request.request_api(action,object,attributes)
puts "------RESEND_APPROVE_EMAIL---------------------------------------"
puts api.request_xml
puts api.response_xml
##
##
action = "RESEND_CERT_EMAIL"
object = "TRUST_SERVICE"
attributes = { order_id: '12' }
api = opensrs_request.request_api(action,object,attributes)
puts "------RESEND_CERT_EMAIL---------------------------------------"
puts api.request_xml
puts api.response_xml
#
#action = "CANCEL_ORDER"
#object = "TRUST_SERVICE"
#attributes = { order_id: '12' }
#api = opensrs_request.request_api(action,object,attributes)
#puts "------CANCEL_ORDER---------------------------------------"
#puts api.request_xml
#puts api.response_xml
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
#
#action = "PARSE_CSR"
#object = "TRUST_SERVICE"
#attributes = { product_type: 'quickssl', csr: sslcert }
#api = opensrs_request.request_api(action,object,attributes)
#puts "------PARSE_CSR---------------------------------------"
#puts api.request_xml
#puts api.response_xml
#
#
#action = "SW_REGISTER"
#object = "TRUST_SERVICE"
#attributes = { order_id: '333' }
#api = opensrs_request.request_api(action,object,attributes)
#puts "------SW_REGISTER NEW---------------------------------------"
#puts api.request_xml
#puts api.response_xml
#
#
##action = "SW_REGISTER"
##object = "TRUST_SERVICE"
##attributes = { reg_type: 'upgrade' }
##api = opensrs_request.request_api(action,object,attributes)
##puts "------SW_REGISTER UPGRADE---------------------------------------"
##puts api.request_xml
##puts api.response_xml
##
##
