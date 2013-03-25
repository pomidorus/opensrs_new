require 'nokogiri'

class OpensrsController < ApplicationController
  respond_to :xml, :only => :index

  def index
    puts request.headers["X-Username"]
    puts request.headers["X-Signature"]
    xml_body = request.body.read
    puts xml_body
    render "layouts/_get_order_info", :formats => [:xml]
  end

end
