#encoding: utf-8
require "spec_helper"

describe "/opensrs", :type => :api do

  before do
    @xml_response_order_info = File.read(File.join(Rails.root, 'spec','api','v1','response_order_info.xml'))
    @xml_request_order_info = File.read(File.join(Rails.root, 'spec','api','v1','request_order_info.xml'))

    @xml_response_product_info = File.read(File.join(Rails.root, 'spec','api','v1','response_product_info.xml'))
    @xml_request_product_info = File.read(File.join(Rails.root, 'spec','api','v1','request_product_info.xml'))

    @headers = {"X-Username" => "aseleznov", "X-Signature" => "password"}
  end

  context 'get order info' do
    it '200' do
      post '/opensrs', {:xml => @xml_request_order_info}, @headers
      response.status.should equal(200)
    end

    it 'body' do
      post '/opensrs', {:xml => @xml_request_order_info}, @headers
      response.body.should == @xml_response_order_info
    end

    it 'username' do
      post '/opensrs', {:xml => @xml_request_order_info}, @headers
      request.headers['X-Username'].should == "aseleznov"
    end

    it 'signature' do
      post '/opensrs', {:xml => @xml_request_order_info}, @headers
      request.headers['X-Signature'].should  == "password"
    end
  end


  context 'get product info' do
    it '200' do
      post '/opensrs', {:xml => @xml_request_product_info}, @headers
      response.status.should equal(200)
    end

    it 'body' do
      post '/opensrs', {:xml => @xml_request_product_info}, @headers
      response.body.should == @xml_response_product_info
    end

    it 'username' do
      post '/opensrs', {:xml => @xml_request_product_info}, @headers
      request.headers['X-Username'].should == "aseleznov"
    end

    it 'signature' do
      post '/opensrs', {:xml => @xml_request_product_info}, @headers
      request.headers['X-Signature'].should  == "password"
    end
  end


end



#puts request.headers['X-Username']
#puts response.body
