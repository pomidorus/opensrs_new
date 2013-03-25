require 'nokogiri'
require 'opensrs'

class OpenSRSRequestParse
  attr :xml

  def initialize(xml)
    @xml = xml
  end

  def request_hash
    request = Nokogiri::XML(xml)
    rh = {}
    request.xpath('//OPS_envelope/dt_assoc/item').each do |item|
      rh[item['key']] = item.content unless item['key'] == "attributes"
    end
    request.xpath('//OPS_envelope/dt_assoc/item/dt_assoc/item').each do |item|
      rh[item['key']] = item.content
    end
    rh
  end
end

class OpenSRSResponse
  attr :request_hash, :client_hash

  def initialize(request_hash, client_hash)
    @request_hash, @client_hash = request_hash, client_hash
  end


  def action
    request_hash["action"]
  end

  def response
    case action
      when "GET_ORDER_INFO"
        "order_info_response"
      when "GET_PRODUCT_INFO"
        "product_info_response"
    end
  end

end

def client_function(hash)
  {}
end

def authenticate_client_function(user,key)
  puts "hello #{user}"
end

class OpensrsController < ApplicationController
  respond_to :xml, :only => :index
  before_filter :authenticate_user

  def index
    username = request.headers["X-Username"]
    signature = request.headers["X-Signature"]

    authenticate_client_function(username,signature)

    opensrs_request = OpenSRSRequestParse.new(request.body.read).request_hash
    #Client function
    hash = client_function(opensrs_request)
    opensrs_response = OpenSRSResponse.new(opensrs_request,hash)

    render "layouts/#{opensrs_response.response}", :formats => [:xml]
  end

  private
  def authenticate_user
    username = request.headers["X-Username"]
    signature = request.headers["X-Signature"]
    @current_user = User.find_by_signature(signature)
      #unless @current_user
      #  respond_with({:error => "Signature is invalid." })
      #end
  end


end


    #puts opensrs_response.at_css("item").text
    #attributes = {:foo => {:bar => 'baz'}}
    #xxml = OpenSRS::XmlProcessor::Nokogiri.build(attributes)
    #puts xxml
    #render :xml => xml_body
    #OpenSRS::Server.xml_processor = :nokogiri
