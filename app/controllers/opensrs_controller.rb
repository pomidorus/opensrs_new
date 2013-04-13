#require "api_opensrs/api_opensrs"
#require 'plugins/api_opensrs/api_opensrs'
require 'api_opensrs'

class OpensrsController < ApplicationController
  respond_to :xml, :only => :index

  SIGNATURE = "X-Signature"
  USERNAME = "X-Username"

  def index
    username = request.headers[USERNAME]
    signature = request.headers[SIGNATURE]

    body_xml = request.body.read

    Rails.logger.debug TestApi.lol
    #request_hash = OpenSRSRequestParse.new(body_xml).request_hash_rexml
    #opensrs = SRSClient.new(request_hash,username,signature)
    #
    #if opensrs.authenticate?
    #  response_hash = opensrs.response
    #  @data = response_hash[:data]
    #  render "layouts/#{response_hash[:layout]}", :formats => [:xml]
    #else
    #  render "layouts/bad_authorization", :formats => [:xml]
    #end

    render "layouts/bad_authorization", :formats => [:xml]
  end
end
