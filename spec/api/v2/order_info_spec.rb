#encoding: utf-8
require "spec_helper"
require 'opensrs'

describe "/opensrs" do

  let(:server_local) {OpenSRS::Server.new(:server   => "http://localhost:3000/opensrs",
                                          :username => "aseleznov",
                                          :password => "53cr3t",
                                          :key      => "c633be3170c7fb3fb29e2f99b84be2410" )}

  let(:server_remote) {OpenSRS::Server.new(:server   => "http://opensrs.herokuapp.com/opensrs",
                                          :username => "aseleznov",
                                          :password => "53cr3t",
                                          :key      => "c633be3170c7fb3fb29e2f99b84be2410" )}

  before(:each) do
    OpenSRS::Server.xml_processor = :nokogiri
  end

  def get_order_info(order_id)
    server_local.call(
          :action => "GET_ORDER_INFO",
          :object => "DOMAIN",
          :attributes => {
            :order_id => order_id
          }
        )
  end

  describe "OrderInfo request" do

    context "request is correct" do

      it "request body is correct" do
        xml_request_order_info = File.read(File.join(Rails.root, 'spec','api','v2','patterns','order_info','request_order_info.xml'))
        get_order_info("34342323").request_xml.should == xml_request_order_info
      end


      it "username is correct" do
        pending
      end

      it "signature is correct"
      it "authorization is correct"


      it "action is GET_ORDER_INFO" do
        opensrs_request = OpenSRSRequestParse.new(get_order_info("34342323").request_xml).request_hash
        opensrs_request["action"].should == "GET_ORDER_INFO"
      end

      it "object is DOMAIN" do
        opensrs_request = OpenSRSRequestParse.new(get_order_info("34342323").request_xml).request_hash
        opensrs_request["object"].should == "DOMAIN"
      end

      it "order_id is 3515690" do
        opensrs_request = OpenSRSRequestParse.new(get_order_info("34342323").request_xml).request_hash
        opensrs_request["order_id"].should == "34342323"
      end

    end

  end


  describe "OrderInfo response" do

    context "response is correct" do

      it "response is OK" do
        get_order_info("34342323").response["response_code"].to_i.should equal(200)
      end

      it "body is correct"  do
        xml_response_order_info = File.read(File.join(Rails.root, 'spec','api','v2','patterns','order_info','response_order_info.xml'))
        get_order_info("34342323").response_xml.should == xml_response_order_info
      end

      xit "owner is correct" do
      end
    end

  end


 end
