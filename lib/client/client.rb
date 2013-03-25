require 'opensrs'

OpenSRS::Server.xml_processor = :nokogiri

server = OpenSRS::Server.new(
  #:server   => "http://opensrs.herokuapp.com/opensrs",
  :server   => "http://localhost:3000/opensrs",
  :username => "aseleznov",
  :password => "53cr3t",
  :key      => "c633be3170c7fb3fb29e2f99b84be2410"
)

request = server.call(
      :action => "GET_ORDER_INFO",
      :object => "DOMAIN",
      :attributes => {
        :order_id => "3515690"
      }
    )

#puts request.inspect
#puts request.response
puts request.request_xml
puts request.response_xml
