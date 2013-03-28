#encoding: utf-8
require "spec_helper"
require 'opensrs'

#describe "/opensrs" do
#
#  describe "CancelOrder request" do
#
#    context "request is correct" do
#      #let(:user) {Factory(:user)}
#      let(:server_local) {OpenSRS::Server.new(:server   => "http://localhost:5000/opensrs",
#                                              :username => "aseleznov",
#                                              :password => "53cr3t",
#                                              :key      => "c633be3170c7fb3fb29e2f99b84be2410" )}
#
#      let(:server_remote) {OpenSRS::Server.new(:server   => "http://localhost:3000/opensrs",
#                                              :username => "aseleznov",
#                                              :password => "53cr3t",
#                                              :key      => "c633be3170c7fb3fb29e2f99b84be2410" )}
#
#      before(:each) do
#        OpenSRS::Server.xml_processor = :nokogiri
#      end
#
#      before(:all) do
#        # User.create!({name: "aseleznov", signature: "2e5e7688aba0879ad1d6b48c724af427"})
#      end
#
#      def get_order_id(order_id)
#        server_local.call(
#          :action => "CANCEL_ORDER",
#          :object => "TRUST_SERVICE",
#          :attributes => {
#            :order_id => order_id
#          }
#        )
#      end
#
#      it "request body is correct" do
#        xml_request_cancel_order = File.read(File.join(Rails.root, 'spec','api','v2','patterns','cancel_order','request_cancel_order.xml'))
#        get_order_id("578").request_xml.should == xml_request_cancel_order
#      end
#
#
#      it "username is correct"
#      it "signature is correct"
#      it "authorization is correct"
#
#
#      it "action is CANCEL_ORDER" do
#        opensrs_request = OpenSRSRequestParse.new(get_order_id("578").request_xml).request_hash
#        opensrs_request["action"].should == "CANCEL_ORDER"
#      end
#
#      it "object is TRUST_SERVICE" do
#        opensrs_request = OpenSRSRequestParse.new(get_order_id("578").request_xml).request_hash
#        opensrs_request["object"].should == "TRUST_SERVICE"
#      end
#
#      it "order_id is 578" do
#        opensrs_request = OpenSRSRequestParse.new(get_order_id("578").request_xml).request_hash
#        opensrs_request["order_id"].should == "578"
#      end
#
#    end
#
#  end
#
#
#  describe "CancelOrder response" do
#
#    context "response is correct" do
#
#      it "response is OK"
#      it "body is correct"
#      it "owner is correct"
#
#    end
#
#  end
#
#
#end
