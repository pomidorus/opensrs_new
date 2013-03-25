require 'nokogiri'
require 'opensrs'

class OpenSRSRequest
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

class OpensrsController < ApplicationController
  respond_to :xml, :only => :index
  before_filter :authenticate_user

  def index
    username = request.headers["X-Username"]
    signature = request.headers["X-Signature"]

    opensrs_request = OpenSRSRequest.new(request.body.read).request_hash
    puts opensrs_request.inspect

    render "layouts/order_info_response", :formats => [:xml]
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
