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


end


opensrs_request = OpenSRSRequest.new("http://localhost:3000/opensrs","aseleznov","53cr3t","c633be3170c7fb3fb29e2f99b84be2410")
#opensrs_request = OpenSRSRequest.new("http://opensrs.herokuapp.com/opensrs","aseleznov","53cr3t","c633be3170c7fb3fb29e2f99b84be2410")

roi = opensrs_request.request_order_info("123242")
rpi = opensrs_request.request_product_info("99")

puts "---------------------------------------------"
puts roi.request_xml
puts roi.response_xml
puts "---------------------------------------------"
puts rpi.request_xml
puts rpi.response_xml


