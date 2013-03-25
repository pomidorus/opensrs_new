#encoding: utf-8
require "spec_helper"
require 'opensrs'


describe "/opensrs" do

  describe "OrderInfo request" do

    context "request is correct" do
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

      def get_order_id(order_id)
        server_local.call(
              :action => "GET_ORDER_INFO",
              :object => "DOMAIN",
              :attributes => {
                :order_id => order_id
              }
            )
      end

      it "request body is correct" do
        get_order_id("34342323").request_xml.should == "<?xml version=\"1.0\"?>\n<OPS_envelope><header/><version/>0.9<body/><data_block/><dt_assoc><item key=\"protocol\">XCP</item><item key=\"action\">GET_ORDER_INFO</item><item key=\"object\">DOMAIN</item><item key=\"attributes\"><dt_assoc><item key=\"order_id\">34342323</item></dt_assoc></item></dt_assoc></OPS_envelope>\n"
      end


      it "username is correct" do
        pending
      end

      it "signature is correct"
      it "authorization is correct"

      it "body is correct"

      it "action is GET_ORDER_INFO"
      it "object is DOMAIN"
      it "order_id is 3515690"

    end

  end


  describe "OrderInfo response" do

    context "response is correct" do

      it "response is OK"
      it "body is correct"
      it "owner is correct"

    end

  end


end