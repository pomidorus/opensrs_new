require 'spec_helper'
require 'sloboda_client'

describe "ApiOpenSRS" do

  let(:dir) { File.dirname(__FILE__) }

  before (:all) do
    @opensrs_request = SlobodaClient::Request.new("http://localhost:3000/opensrs","aseleznov","53cr3t","c633be3170c7fb3fb29e2f99b84be2410")
  end

  #------------------------------------------------------------------------

  context 'authorization' do
    it 'user Seleznov should login'
    it 'user Sokoliv should not login'
  end

  #------------------------------------------------------------------------

  #returns Order information, including the order state. If the state is complete, returns the Product ID
  context 'GET_ORDER_INFO' do
    before (:all) do
      #For a .RU domain order
      action = "GET_ORDER_INFO"
      object = "DOMAIN"
      attributes = { order_id: '123746'}
      @api = @opensrs_request.request_api(action,object,attributes)
    end

    it 'request should be correct' do
      xml_request = open("#{dir}/get_order_info_request.xml", 'r').readlines.join
      @api.request_xml.should  eql(xml_request)
    end

    it 'response should be correct' do
      xml_response = open("#{dir}/get_order_info_response.xml", 'r').readlines.join
      @api.response_xml.should eql(xml_response)
    end

    it 'Product ID should be present' do
      @api.response["attributes"]["field_hash"]["id"].should_not eql(nil)
    end

    it 'Product ID should not be empty' do
      @api.response["attributes"]["field_hash"]["id"].empty?.should_not be_true
    end

    it 'request without required attribute should return correct message'
  end

  #------------------------------------------------------------------------

  #Returns information about the issued certificate.
  #В методе Get Product Info помимо информации о сертификате нужно возвращать сам сертификат (certificate body).
  context 'GET_PRODUCT_INFO' do
    before (:all) do
      ##Retrieves the properties for a Trust Service product.
      action = "GET_PRODUCT_INFO"
      object = "TRUST_SERVICE"
      attributes = { product_id: '123746' }
      @api = @opensrs_request.request_api(action,object,attributes)
    end

    it 'request should be correct' do
      xml_request = ""
      @api.request_xml.should  eql(xml_request)
    end

    it 'response should be correct' do
      xml_response = ""
      @api.response_xml.should eql(xml_response)
    end

    it 'certificate body should be present' do
      pending
    end

    it 'certificate body should not be blank' do
      pending
    end
    it 'request without required attribute should return correct message'
  end

  #------------------------------------------------------------------------

  context 'GET_PRODUCT_INFO_ALL' do
    it 'request should be correct' do

    end

    it 'response should be correct' do

    end
  end

  #Query a list of approver email addresses allowed for the domain to which the request's approval email will be sent
  context 'QUERY_APPROVER_LIST' do
    it 'request should be correct' do
      pending
      true.should == false
    end
    it 'response should be correct'
  end

  #Request the approval email be re-sent based on an Order ID
  context 'RESEND_APPROVE_EMAIL' do
    it 'request should be correct' do
      pending
      true.should == false
    end
    it 'response should be correct'
  end

  #Request the certificate email be re-sent based on an Order ID
  context 'RESEND_CERT_EMAIL' do
    it 'request should be correct' do
      pending
      true.should == false
    end
    it 'response should be correct'
  end

  #A request can only be cancelled if the order is in progress. It can not be canceled after the order has completed
  context 'CANCEL_ORDER' do
    it 'request should be correct' do
      pending
      true.should == false
    end
    it 'response should be correct'
  end

  #Parse the CSR submitted by the user to present them back the configured values to then finally confirm and process their request
  context 'PARSE_CSR' do
    it 'request should be correct' do
      pending
      true.should == false
    end
    it 'response should be correct'
  end

  #Submit order information for processing immediately, and obtain an Order ID
  context 'SW_REGISTER NEW DOMAIN' do
    it 'request should be correct' do
      pending
      true.should == false
    end
    it 'response should be correct'
  end

  context 'SW_REGISTER NEW TRUST_SERVICE' do
    it 'request should be correct' do
      pending
      true.should == false
    end
    it 'response should be correct'
  end

  #Request renewal of certificate using existing CSR and other information pulled from existing Order using Order ID
  context 'SW_REGISTER RENEW TRUST_SERVICE' do
    it 'request should be correct' do
      pending
      true.should == false
    end
    it 'response should be correct'
  end


end