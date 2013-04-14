require 'spec_helper'
require 'sloboda_client'

describe "ApiOpenSRS" do

  context 'authorization' do
    it 'user Seleznov should login'
    it 'user Sokoliv should not login'
  end

  #returns Order information, including the order state. If the state is complete, returns the Product ID
  context 'GET_ORDER_INFO' do
    it 'request should be correct' do
      pending
      true.should == false
    end
    it 'response should be correct'
    it 'Product ID should be present'
    it 'Product ID should not be blank'
  end

  #Returns information about the issued certificate.
  #В методе Get Product Info помимо информации о сертификате нужно возвращать сам сертификат (certificate body).
  context 'GET_PRODUCT_INFO' do
    it 'request should be correct' do
      pending
      true.should == false
    end
    it 'response should be correct'
    it 'certificate body should be present'
    it 'certificate body should not be blank'
  end

  context 'GET_PRODUCT_INFO_ALL' do
    it 'request should be correct' do
      pending
      true.should == false
    end
    it 'response should be correct'
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