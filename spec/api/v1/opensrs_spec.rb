#encoding: utf-8
require "spec_helper"

describe "/opensrs", :type => :api do

  before do
    @xml_request_order_info = File.read(File.join(Rails.root, 'spec','api','v1','order_info','request_order_info.xml'))
    @xml_response_order_info = File.read(File.join(Rails.root, 'spec','api','v1','order_info','response_order_info.xml'))

    @xml_request_product_info = File.read(File.join(Rails.root, 'spec','api','v1','product_info','request_product_info.xml'))
    @xml_response_product_info = File.read(File.join(Rails.root, 'spec','api','v1','product_info','response_product_info.xml'))

    @xml_request_parse_csr = File.read(File.join(Rails.root, 'spec','api','v1','parse_csr','request_parse_csr.xml'))
    @xml_response_parse_csr = File.read(File.join(Rails.root, 'spec','api','v1','parse_csr','response_parse_csr.xml'))

    @xml_request_trust_service_order = File.read(File.join(Rails.root, 'spec','api','v1','register_ssl_cert','request_trust_service_order.xml'))
    @xml_response_trust_service_order = File.read(File.join(Rails.root, 'spec','api','v1','register_ssl_cert','response_trust_service_order.xml'))

    # start tests for renew ssl
    @xml_request_renewal_order_for_a_quickssl_certificate = File.read(File.join(Rails.root, 'spec','api','v1','renew_ssl','request_renewal_order_for_a_quickssl_certificate.xml'))
    @xml_response_renewal_order_for_a_quickssl_certificate = File.read(File.join(Rails.root, 'spec','api','v1','renew_ssl','response_renewal_order_for_a_quickssl_certificate.xml'))

    @xml_request_an_order_to_upgrade_a_sitelock_ssl_certificate_to_sitelock_premium = File.read(File.join(Rails.root, 'spec','api','v1','renew_ssl','request_an_order_to_upgrade_a_sitelock_ssl_certificate_to_sitelock_premium.xml'))
    @xml_response_an_order_to_upgrade_a_sitelock_ssl_certificate_to_sitelock_premium = File.read(File.join(Rails.root, 'spec','api','v1','renew_ssl','response_an_order_to_upgrade_a_sitelock_ssl_certificate_to_sitelock_premium.xml'))

    @xml_request_an_order_for_a_geotrust_web_site_anti_malware_scan_certificate = File.read(File.join(Rails.root, 'spec','api','v1','renew_ssl','request_an_order_for_a_geotrust_web_site_anti_malware_scan_certificate.xml'))
    @xml_response_an_order_for_a_geotrust_web_site_anti_malware_scan_certificate = File.read(File.join(Rails.root, 'spec','api','v1','renew_ssl','response_an_order_for_a_geotrust_web_site_anti_malware_scan_certificate.xml'))

    @xml_request_an_order_for_a_30_day_free_trial_of_a_symantec_securesite_certificate = File.read(File.join(Rails.root, 'spec','api','v1','renew_ssl','request_an_order_for_a_30_day_free_trial_of_a_symantec_securesite_certificate.xml'))
    @xml_response_an_order_for_a_30_day_free_trial_of_a_symantec_securesite_certificate = File.read(File.join(Rails.root, 'spec','api','v1','renew_ssl','response_an_order_for_a_30_day_free_trial_of_a_symantec_securesite_certificate.xml'))

    @xml_request_a_new_order_for_a_quickssl_certificate_based_on_an_existing_order = File.read(File.join(Rails.root, 'spec','api','v1','renew_ssl','request_a_new_order_for_a_quickssl_certificate_based_on_an_existing_order.xml'))
    @xml_response_a_new_order_for_a_quickssl_certificate_based_on_an_existing_order = File.read(File.join(Rails.root, 'spec','api','v1','renew_ssl','response_a_new_order_for_a_quickssl_certificate_based_on_an_existing_order.xml'))

    @xml_request_a_renewal_order_for_a_quickssl_certificate_that_was_submitted_by_using_the_order_id = File.read(File.join(Rails.root, 'spec','api','v1','renew_ssl','request_a_renewal_order_for_a_quickssl_certificate_that_was_submitted_by_using_the_order_id.xml'))
    @xml_response_a_renewal_order_for_a_quickssl_certificate_that_was_submitted_by_using_the_order_id = File.read(File.join(Rails.root, 'spec','api','v1','renew_ssl','response_a_renewal_order_for_a_quickssl_certificate_that_was_submitted_by_using_the_order_id.xml'))

    @xml_request_a_renewal_order_for_a_quickssl_certificate_that_was_submitted_by_using_the_product_id = File.read(File.join(Rails.root, 'spec','api','v1','renew_ssl','request_a_renewal_order_for_a_quickssl_certificate_that_was_submitted_by_using_the_product_id.xml'))
    @xml_response_a_renewal_order_for_a_quickssl_certificate_that_was_submitted_by_using_the_product_id = File.read(File.join(Rails.root, 'spec','api','v1','renew_ssl','response_a_renewal_order_for_a_quickssl_certificate_that_was_submitted_by_using_the_product_id.xml'))
    # end tests for renew ssl


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


  context 'get parse crs' do
    it '200' do
      post '/opensrs', {:xml => @xml_request_parse_csr}, @headers
      response.status.should equal(200)
    end

    it 'body' do
      post '/opensrs', {:xml => @xml_request_parse_csr}, @headers
      response.body.should == @xml_response_parse_csr
    end

    it 'username' do
      post '/opensrs', {:xml => @xml_request_parse_csr}, @headers
      request.headers['X-Username'].should == "aseleznov"
    end

    it 'signature' do
      post '/opensrs', {:xml => @xml_request_parse_csr}, @headers
      request.headers['X-Signature'].should  == "password"
    end
  end

  context 'get trust sevice order (register ssl cert)' do
    it '200' do
      post '/opensrs', {:xml => @xml_request_trust_service_order}, @headers
      response.status.should equal(200)
    end

    it 'body' do
      post '/opensrs', {:xml => @xml_request_trust_service_order}, @headers
      response.body.should == @xml_response_trust_service_order
    end

    it 'username' do
      post '/opensrs', {:xml => @xml_request_trust_service_order}, @headers
      request.headers['X-Username'].should == "aseleznov"
    end

    it 'signature' do
      post '/opensrs', {:xml => @xml_request_trust_service_order}, @headers
      request.headers['X-Signature'].should  == "password"
    end
  end

  context 'get renew ssl (renewal order for a quickssl certificate)' do
    it '200' do
      post '/opensrs', {:xml => @xml_request_renewal_order_for_a_quickssl_certificate}, @headers
      response.status.should equal(200)
    end

    it 'body' do
      post '/opensrs', {:xml => @xml_request_renewal_order_for_a_quickssl_certificate}, @headers
      response.body.should == @xml_response_renewal_order_for_a_quickssl_certificate
    end

    it 'username' do
      post '/opensrs', {:xml => @xml_request_renewal_order_for_a_quickssl_certificate}, @headers
      request.headers['X-Username'].should == "aseleznov"
    end

    it 'signature' do
      post '/opensrs', {:xml => @xml_request_renewal_order_for_a_quickssl_certificate}, @headers
      request.headers['X-Signature'].should  == "password"
    end
  end

  context 'get renew ssl (an order to upgrade a sitelock ssl certificate to sitelock premium)' do
    it '200' do
      post '/opensrs', {:xml => @xml_request_an_order_to_upgrade_a_sitelock_ssl_certificate_to_sitelock_premium}, @headers
      response.status.should equal(200)
    end

    it 'body' do
      post '/opensrs', {:xml => @xml_request_an_order_to_upgrade_a_sitelock_ssl_certificate_to_sitelock_premium}, @headers
      response.body.should == @xml_response_an_order_to_upgrade_a_sitelock_ssl_certificate_to_sitelock_premium
    end

    it 'username' do
      post '/opensrs', {:xml => @xml_request_an_order_to_upgrade_a_sitelock_ssl_certificate_to_sitelock_premium}, @headers
      request.headers['X-Username'].should == "aseleznov"
    end

    it 'signature' do
      post '/opensrs', {:xml => @xml_request_an_order_to_upgrade_a_sitelock_ssl_certificate_to_sitelock_premium}, @headers
      request.headers['X-Signature'].should  == "password"
    end
  end

  context 'get renew ssl (an order for a geotrust web site anti malware scan certificate)' do
    it '200' do
      post '/opensrs', {:xml => @xml_request_an_order_for_a_geotrust_web_site_anti_malware_scan_certificate}, @headers
      response.status.should equal(200)
    end

    it 'body' do
      post '/opensrs', {:xml => @xml_request_an_order_for_a_geotrust_web_site_anti_malware_scan_certificate}, @headers
      response.body.should == @xml_response_an_order_for_a_geotrust_web_site_anti_malware_scan_certificate
    end

    it 'username' do
      post '/opensrs', {:xml => @xml_request_an_order_for_a_geotrust_web_site_anti_malware_scan_certificate}, @headers
      request.headers['X-Username'].should == "aseleznov"
    end

    it 'signature' do
      post '/opensrs', {:xml => @xml_request_an_order_for_a_geotrust_web_site_anti_malware_scan_certificate}, @headers
      request.headers['X-Signature'].should  == "password"
    end
  end

  context 'get renew ssl (an order for a 30 day free trial of a symantec securesite certificate)' do
    it '200' do
      post '/opensrs', {:xml => @xml_request_an_order_for_a_30_day_free_trial_of_a_symantec_securesite_certificate}, @headers
      response.status.should equal(200)
    end

    it 'body' do
      post '/opensrs', {:xml => @xml_request_an_order_for_a_30_day_free_trial_of_a_symantec_securesite_certificate}, @headers
      response.body.should == @xml_response_an_order_for_a_30_day_free_trial_of_a_symantec_securesite_certificate
    end

    it 'username' do
      post '/opensrs', {:xml => @xml_request_an_order_for_a_30_day_free_trial_of_a_symantec_securesite_certificate}, @headers
      request.headers['X-Username'].should == "aseleznov"
    end

    it 'signature' do
      post '/opensrs', {:xml => @xml_request_an_order_for_a_30_day_free_trial_of_a_symantec_securesite_certificate}, @headers
      request.headers['X-Signature'].should  == "password"
    end
  end

  context 'get renew ssl (a new order for a quickssl certificate based on an existing order)' do
    it '200' do
      post '/opensrs', {:xml => @xml_request_a_new_order_for_a_quickssl_certificate_based_on_an_existing_order}, @headers
      response.status.should equal(200)
    end

    it 'body' do
      post '/opensrs', {:xml => @xml_request_a_new_order_for_a_quickssl_certificate_based_on_an_existing_order}, @headers
      response.body.should == @xml_response_a_new_order_for_a_quickssl_certificate_based_on_an_existing_order
    end

    it 'username' do
      post '/opensrs', {:xml => @xml_request_a_new_order_for_a_quickssl_certificate_based_on_an_existing_order}, @headers
      request.headers['X-Username'].should == "aseleznov"
    end

    it 'signature' do
      post '/opensrs', {:xml => @xml_request_a_new_order_for_a_quickssl_certificate_based_on_an_existing_order}, @headers
      request.headers['X-Signature'].should  == "password"
    end
  end

  context 'get renew ssl (a renewal order for a quickssl certificate that was submitted by using the order id)' do
    it '200' do
      post '/opensrs', {:xml => @xml_request_a_renewal_order_for_a_quickssl_certificate_that_was_submitted_by_using_the_order_id}, @headers
      response.status.should equal(200)
    end

    it 'body' do
      post '/opensrs', {:xml => @xml_request_a_renewal_order_for_a_quickssl_certificate_that_was_submitted_by_using_the_order_id}, @headers
      response.body.should == @xml_response_a_renewal_order_for_a_quickssl_certificate_that_was_submitted_by_using_the_order_id
    end

    it 'username' do
      post '/opensrs', {:xml => @xml_request_a_renewal_order_for_a_quickssl_certificate_that_was_submitted_by_using_the_order_id}, @headers
      request.headers['X-Username'].should == "aseleznov"
    end

    it 'signature' do
      post '/opensrs', {:xml => @xml_request_a_renewal_order_for_a_quickssl_certificate_that_was_submitted_by_using_the_order_id}, @headers
      request.headers['X-Signature'].should  == "password"
    end
  end

  context 'get renew ssl (a renewal order for a quickssl certificate that was submitted by using the product id)' do
    it '200' do
      post '/opensrs', {:xml => @xml_request_a_renewal_order_for_a_quickssl_certificate_that_was_submitted_by_using_the_product_id}, @headers
      response.status.should equal(200)
    end

    it 'body' do
      post '/opensrs', {:xml => @xml_request_a_renewal_order_for_a_quickssl_certificate_that_was_submitted_by_using_the_product_id}, @headers
      response.body.should == @xml_response_a_renewal_order_for_a_quickssl_certificate_that_was_submitted_by_using_the_product_id
    end

    it 'username' do
      post '/opensrs', {:xml => @xml_request_a_renewal_order_for_a_quickssl_certificate_that_was_submitted_by_using_the_product_id}, @headers
      request.headers['X-Username'].should == "aseleznov"
    end

    it 'signature' do
      post '/opensrs', {:xml => @xml_request_a_renewal_order_for_a_quickssl_certificate_that_was_submitted_by_using_the_product_id}, @headers
      request.headers['X-Signature'].should  == "password"
    end
  end

end



#puts request.headers['X-Username']
#puts response.body
