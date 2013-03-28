#encoding: utf-8
require "spec_helper"
require 'opensrs'

describe "/opensrs" do

  let(:server_local) {OpenSRS::Server.new(:server   => "http://localhost:3000/opensrs",
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

  def get_register_ssl_cert(order_id)
    server_local.call(
      :action => "SW_REGISTER",
      :object => "TRUST_SERVICE",
      :attributes => {
        :order_id => order_id
      }
    )
  end

  describe "Register SSL cert request" do

    context "request is correct" do

      it "request body is correct" do
        xml_request_register_ssl_cert = File.read(File.join(Rails.root, 'spec','api','v2','patterns','register_ssl_cert','request_trust_service_order.xml'))
        get_register_ssl_cert("327").request_xml.should == xml_request_register_ssl_cert
      end


      it "username is correct"
      it "signature is correct"
      it "authorization is correct"


      it "action is SW_REGISTER" do
        opensrs_request = OpenSRSRequestParse.new(get_register_ssl_cert("327").request_xml).request_hash
        opensrs_request["action"].should == "SW_REGISTER"
      end

      it "object is TRUST_SERVICE" do
        opensrs_request = OpenSRSRequestParse.new(get_register_ssl_cert("327").request_xml).request_hash
        opensrs_request["object"].should == "TRUST_SERVICE"
      end

      it "order_id is 327" do
        opensrs_request = OpenSRSRequestParse.new(get_register_ssl_cert("327").request_xml).request_hash
        opensrs_request["order_id"].should == "327"
      end

    end

  end


  describe "Register SSL cert response" do

    context "response is correct" do

      it "response is OK" do
        get_register_ssl_cert("327").response["response_code"].to_i.should equal(200)
      end

      it "body is correct"  do
        xml_response_register_ssl_cert = File.read(File.join(Rails.root, 'spec','api','v2','patterns','register_ssl_cert','response_trust_service_order.xml'))
        get_register_ssl_cert("327").response_xml.should == xml_response_register_ssl_cert
      end

      xit "owner is correct" do
      end
    end

  end


end
