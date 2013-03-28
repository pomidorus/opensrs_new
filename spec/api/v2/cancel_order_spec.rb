#encoding: utf-8
require "spec_helper"
require 'opensrs'

describe "/opensrs" do

  #let(:user) {Factory(:user)}
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

  def get_cancel_order(order_id)
    server_local.call(
      :action => "CANCEL_ORDER",
      :object => "TRUST_SERVICE",
      :attributes => {
        :order_id => order_id
      }
    )
  end

  describe "CancelOrder request" do

    context "request is correct" do

      it "request body is correct" do
        xml_request_cancel_order = File.read(File.join(Rails.root, 'spec','api','v2','patterns','cancel_order','request_cancel_order.xml'))
        get_cancel_order("578").request_xml.should == xml_request_cancel_order
      end


      it "username is correct"
      it "signature is correct"
      it "authorization is correct"


      it "action is CANCEL_ORDER" do
        opensrs_request = OpenSRSRequestParse.new(get_cancel_order("578").request_xml).request_hash
        opensrs_request["action"].should == "CANCEL_ORDER"
      end

      it "object is TRUST_SERVICE" do
        opensrs_request = OpenSRSRequestParse.new(get_cancel_order("578").request_xml).request_hash
        opensrs_request["object"].should == "TRUST_SERVICE"
      end

      it "order_id is 578" do
        opensrs_request = OpenSRSRequestParse.new(get_cancel_order("578").request_xml).request_hash
        opensrs_request["order_id"].should == "578"
      end

    end

  end


  describe "CancelOrder response" do

    context "response is correct" do

      it "response is OK" do
        get_cancel_order("578").response["response_code"].to_i.should equal(200)
      end

      it "body is correct"  do
        xml_response_cancel_order = File.read(File.join(Rails.root, 'spec','api','v2','patterns','cancel_order','response_cancel_order.xml'))
        get_cancel_order("578").response_xml.should == xml_response_cancel_order
      end

      xit "owner is correct" do
      end
    end

  end


 end
