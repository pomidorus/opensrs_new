require 'opensrs'


class OpenSRSRequest
  attr :server, :username, :password, :key

  def initialize(server,username,password,key)
    OpenSRS::Server.xml_processor = :nokogiri
    @server, @username, @password, @key = server, username, password, key
  end

  def remote_server
    OpenSRS::Server.new(
      :server   => server,
      :username => username,
      :password => password,
      :key      => key
    )
  end

  def request_order_info(order_id)
    remote_server.call(
          :action => "GET_ORDER_INFO",
          :object => "DOMAIN",
          :attributes => {
            :order_id => order_id
          }
        )
  end

  def request_product_info(product_id)
    remote_server.call(
          :action => "GET_PRODUCT_INFO",
          :object => "TRUST_SERVICE",
          :attributes => {
            :product_id => product_id
          }
        )
  end

  def request_cancel_order(order_id)
    remote_server.call(
          :action => "CANCEL_ORDER",
          :object => "TRUST_SERVICE",
          :attributes => {
            :order_id => order_id
          }
        )
  end

  def request_parse_csr(product_type, csr)
    remote_server.call(
          :action => "CANCEL_ORDER",
          :object => "TRUST_SERVICE",
          :attributes => {
            :product_type => product_type,
            :csr => csr
          }
        )
  end

  def request_register_ssl_cert(order_id)
    remote_server.call(
          :action => "GET_ORDER_INFO",
          :object => "TRUST_SERVICE",
          :attributes => {
            :order_id => order_id
          }
        )
  end

end


opensrs_request = OpenSRSRequest.new("http://localhost:3000/opensrs","aseleznov","53cr3t","c633be3170c7fb3fb29e2f99b84be2410")
#opensrs_request = OpenSRSRequest.new("http://opensrs.herokuapp.com/opensrs","aseleznov","53cr3t","c633be3170c7fb3fb29e2f99b84be2410")

roi = opensrs_request.request_order_info("123242")
rpi = opensrs_request.request_product_info("99")
rco = opensrs_request.request_cancel_order("34453")

sslcert = %q(-----BEGIN CERTIFICATE REQUEST----- MIIBqTCCARICAQAwaTELMAkGA1UEBhMCQ0ExCzAJBgNVBAgTAm9uMRAwDgYDVQQH
Ewd0b3JvbnRvMQ8wDQYDVQQKEwZ0dWNvd3MxCzAJBgNVBAsTAnFhMR0wGwYDVQQD
ExR3d3cucWFyZWdyZXNzaW9uLm9yZzCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkC
gYEAz+hbqqnE5BSW0THf7txxsJxF8Vtca2uL52iutI1SRTm9J6NNtAjgMbL9upOm
SFnObpWKriUIlvxKrecygGWkjiMeyU/F6auAS9/vwDdxYEVT2szK+Q2At1FgU433
Pds53v2J/vyB6SL+k/w54H2gF4ORpU1hjUggo7fM353TeeMCAwEAAaAAMA0GCSqG
SIb3DQEBBAUAA4GBAIYvVThVeocN7N7HbsO/au9AXnx6LULQ5LMDWx6FlyBB5g9h
5HYZa6xieYCYDxYIsjLjR3qx1BWl9+0kSL2MW4EdDPzbcrZvHAtrw2/hPrm9EGA3
2w3a26W79N3clCkrahnpcNFLFyzU3CtZASJ+VuixGXTEkdiBAliqtGp+QBhf -----END
CERTIFICATE REQUEST-----)
rpc = opensrs_request.request_parse_csr("quickssl",sslcert)

rsc = opensrs_request.request_register_ssl_cert("2324434")

puts "---------------------------------------------"
puts roi.request_xml
puts roi.response_xml
puts "---------------------------------------------"
puts rpi.request_xml
puts rpi.response_xml
puts "---------------------------------------------"
puts rco.request_xml
puts rco.response_xml
puts "---------------------------------------------"
puts rpc.request_xml
puts rpc.response_xml
puts "---------------------------------------------"
puts rsc.request_xml
puts rsc.response_xml


