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

 def get_product_info(product_id)
   server_local.call(
         :action => "GET_PRODUCT_INFO",
         :object => "TRUST_SERVICE",
         :attributes => {
           :product_id => product_id
         }
       )
 end

 describe "ProductInfo request" do

   context "request is correct" do

     it "request body is correct" do
       xml_request_product_info = File.read(File.join(Rails.root, 'spec','api','v2','patterns','product_info','request_product_info.xml'))
       get_product_info("34342323").request_xml.should == xml_request_product_info
     end


     it "username is correct" do
       pending
     end

     it "signature is correct"
     it "authorization is correct"


     it "action is GET_PRODUCT_INFO" do
       opensrs_request = OpenSRSRequestParse.new(get_product_info("34342323").request_xml).request_hash
       opensrs_request["action"].should == "GET_PRODUCT_INFO"
     end

     it "object is TRUST_SERVICE" do
       opensrs_request = OpenSRSRequestParse.new(get_product_info("34342323").request_xml).request_hash
       opensrs_request["object"].should == "TRUST_SERVICE"
     end

     it "product_id is 3515690" do
       opensrs_request = OpenSRSRequestParse.new(get_product_info("34342323").request_xml).request_hash
       opensrs_request["product_id"].should == "34342323"
     end

   end

 end


 describe "ProductInfo response" do

   context "response is correct" do

      it "response is OK" do
        get_product_info("123123123213").response["response_code"].to_i.should equal(200)
      end

      it "body is correct"  do
        xml_response_product_info = File.read(File.join(Rails.root, 'spec','api','v2','patterns','product_info','response_product_info.xml'))
        get_product_info("123123123213").response_xml.should == xml_response_product_info
      end

      xit "owner is correct" do
      end
   end

 end


end
