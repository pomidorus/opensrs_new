#encoding: utf-8
require "spec_helper"
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


describe "/opensrs" do

  describe "Register SSL cert request" do

    context "request is correct" do
      #let(:user) {Factory(:user)}
      let(:server_local) {OpenSRS::Server.new(:server   => "http://localhost:5000/opensrs",
                                              :username => "aseleznov",
                                              :password => "53cr3t",
                                              :key      => "c633be3170c7fb3fb29e2f99b84be2410" )}

      let(:server_remote) {OpenSRS::Server.new(:server   => "http://localhost:3000/opensrs",
                                              :username => "aseleznov",
                                              :password => "53cr3t",
                                              :key      => "c633be3170c7fb3fb29e2f99b84be2410" )}

      before(:each) do
        OpenSRS::Server.xml_processor = :nokogiri
      end

      before(:all) do
        @csr = '-----BEGIN CERTIFICATE REQUEST----- MIIBqTCCARICAQAwaTELMAkGA1UEBhMCQ0ExCzAJBgNVBAgTAm9uMRAwDgYDVQ QH Ewd0b3JvbnRvMQ8wDQYDVQQKEwZ0dWNvd3MxCzAJBgNVBAsTAnFhMR0wGwYDVQ QD ExR3d3cucWFyZWdyZXNzaW9uLm9yZzCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkC gYEAz+hbqqnE5BSW0THf7txxsJxF8Vtca2uL52iutI1SRTm9J6NNtAjgMbL9upOm SFnObpWKriUIlvxKrecygGWkjiMeyU/F6auAS9/vwDdxYEVT2szK+Q2At1FgU433 Pds53v2J/vyB6SL+k/w54H2gF4ORpU1hjUggo7fM353TeeMCAwEAAaAAMA0GCSqG SIb3DQEBBAUAA4GBAIYvVThVeocN7N7HbsO/au9AXnx6LULQ5LMDWx6FlyBB5g9h 5HYZa6xieYCYDxYIsjLjR3qx1BWl9+0kSL2MW4EdDPzbcrZvHAtrw2/hPrm9EGA3 2w3a26W79N3clCkrahnpcNFLFyzU3CtZASJ+VuixGXTEkdiBAliqtGp+QBhf -----END CERTIFICATE REQUEST-----'
        # User.create!({name: "aseleznov", signature: "2e5e7688aba0879ad1d6b48c724af427"})
      end

      def get_register_ssl_cert(order_id)
        server_local.call(
          :action => "SW_REGISTER",
          :object => "TRUST_SERVICE",
          :attributes => {
            :order_id => order_id
          }
        )
      end

      it "request body is correct" do
        xml_request_register_ssl_cert = File.read(File.join(Rails.root, 'spec','api','v2','patterns','register_ssl_cert','request_trust_service_order.xml'))
        get_register_ssl_cert("327").request_xml.should == xml_request_register_ssl_cert
      end


      it "username is correct"
      it "signature is correct"
      it "authorization is correct"


      it "action is SW_REGISTER" do
        opensrs_request = OpenSRSRequest.new(get_register_ssl_cert("327").request_xml).request_hash
        opensrs_request["action"].should == "SW_REGISTER"
      end

      it "object is TRUST_SERVICE" do
        opensrs_request = OpenSRSRequest.new(get_register_ssl_cert("327").request_xml).request_hash
        opensrs_request["object"].should == "TRUST_SERVICE"
      end

      it "order_id is 327" do
        opensrs_request = OpenSRSRequest.new(get_register_ssl_cert("327").request_xml).request_hash
        opensrs_request["order_id"].should == "327"
      end

    end

  end


  describe "Register SSL cert response" do

    context "response is correct" do

      it "response is OK"
      it "body is correct"
      it "owner is correct"

    end

  end


end
