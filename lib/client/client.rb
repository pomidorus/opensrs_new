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

  #TODO: Refactor to one function

  def request_api(action,object,attributes)
    remote_server.call(
          :action => action,
          :object => object,
          :attributes => attributes
        )
  end



  def cancel_order(order_id)
    remote_server.call(
          :action => "CANCEL_ORDER",
          :object => "TRUST_SERVICE",
          :attributes => {
            :order_id => order_id
          }
        )
  end

  def parse_csr(product_type, csr)
    remote_server.call(
          :action => "PARSE_CSR",
          :object => "TRUST_SERVICE",
          :attributes => {
            :product_type => product_type,
            :csr => csr
          }
        )
  end

  def register_ssl_cert(order_id)
    remote_server.call(
          :action => "SW_REGISTER",
          :object => "TRUST_SERVICE",
          :attributes => {
            :order_id => order_id
          }
        )
  end


  def renew_ssl(attributes)
    remote_server.call(
      :action => "SW_REGISTER",
      :object => "TRUST_SERVICE",
      :attributes => attributes
    )
  end

end


opensrs_request = OpenSRSRequest.new("http://localhost:3000/opensrs","aseleznov","53cr3t","c633be3170c7fb3fb29e2f99b84be2410")
#opensrs_request = OpenSRSRequest.new("http://opensrs.herokuapp.com/opensrs","aseleznov","53cr3t","c633be3170c7fb3fb29e2f99b84be2410")


action = "SW_REGISTER"
object = "TRUST_SERVICE"
attributes = { reg_type: 'upgrade' }
api = opensrs_request.request_api(action,object,attributes)
puts "---------RENEW_SSL-----------------------------------"
puts api.request_xml
puts api.response_xml


action = "GET_ORDER_INFO"
object = "DOMAIN"
attributes = { order_id: '123746' }
api = opensrs_request.request_api(action,object,attributes)
puts "------GET_ORDER_INFO---------------------------------------"
puts api.request_xml
puts api.response_xml


action = "GET_PRODUCT_INFO"
object = "TRUST_SERVICE"
attributes = { product_id: '123746' }
api = opensrs_request.request_api(action,object,attributes)
puts "------GET_PRODUCT_INFO---------------------------------------"
puts api.request_xml
puts api.response_xml

action = "QUERY_APPROVER_LIST"
object = "TRUST_SERVICE"
attributes = { domain: 'www.mail.ru', product_type: "quickssl" }
api = opensrs_request.request_api(action,object,attributes)
puts "------QUERY_APPROVER_LIST---------------------------------------"
puts api.request_xml
puts api.response_xml

action = "RESEND_APPROVE_EMAIL"
object = "TRUST_SERVICE"
attributes = { order_id: '123432' }
api = opensrs_request.request_api(action,object,attributes)
puts "------RESEND_APPROVE_EMAIL---------------------------------------"
puts api.request_xml
puts api.response_xml


action = "RESEND_CERT_EMAIL"
object = "TRUST_SERVICE"
attributes = { order_id: '12' }
api = opensrs_request.request_api(action,object,attributes)
puts "------RESEND_CERT_EMAIL---------------------------------------"
puts api.request_xml
puts api.response_xml


