require 'nokogiri'
require 'opensrs'

class OpenSRSRequest
  attr :xml

  def initialize(xml)
    @xml = xml
  end

end

class OpensrsController < ApplicationController
  respond_to :xml, :only => :index

  def index
    username = request.headers["X-Username"]
    signature = request.headers["X-Signature"]


    # refactor to class
    opensrs_response = Nokogiri::XML(request.body.read)
    opensrs_response.xpath('//OPS_envelope/dt_assoc/item').each do |link|
      puts link['key']
      puts link.content
    end

    render "layouts/_get_order_info", :formats => [:xml]
  end

end


    #puts opensrs_response.at_css("item").text
    #attributes = {:foo => {:bar => 'baz'}}
    #xxml = OpenSRS::XmlProcessor::Nokogiri.build(attributes)
    #puts xxml
    #render :xml => xml_body
    #OpenSRS::Server.xml_processor = :nokogiri
