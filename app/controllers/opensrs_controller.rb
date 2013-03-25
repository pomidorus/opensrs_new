require 'nokogiri'

class OpensrsController < ApplicationController
  respond_to :xml, :only => :index

  def index
    puts request.headers["X-Username"]
    puts request.headers["X-Signature"]
    xml = Nokogiri::XML(params[:xml])
    puts xml
    # render "layouts/_get_order_info", :formats => [:xml], :header => {'sss' => 'ddd'}
    # render "layouts/_get_parse_csr", :formats => [:xml], :header => {'sss' => 'ddd'}
    render "layouts/_get_trust_service_order", :formats => [:xml], :header => {'sss' => 'ddd'}
  end

end
