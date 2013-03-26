#encoding: utf-8
require "spec_helper"
require 'opensrs'

class OpenSRSRequest
  attr :xml

  def initialize(xml)
    @xml = xml
  end

  def request_hash
    request = Nokogiri::XML(xml)
    rh = {}
    request.xpath('//OPS_envelope/dt_assoc/item').each do |item|
      rh[item['key']] = item.content unless item['key'] == "attributes"
    end
    request.xpath('//OPS_envelope/dt_assoc/item/dt_assoc/item').each do |item|
      rh[item['key']] = item.content
    end
    rh
  end

end


describe "/opensrs" do

  describe "Renew SSL request" do

    context "request is correct" do
      #let(:user) {Factory(:user)}
      let(:server_local) {OpenSRS::Server.new(:server   => "http://localhost:5000/opensrs",
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

      before(:all) do
        @csr = '-----BEGIN CERTIFICATE REQUEST----- MIIBqTCCARICAQAwaTELMAkGA1UEBhMCQ0ExCzAJBgNVBAgTAm9uMRAwDgYDVQ QH Ewd0b3JvbnRvMQ8wDQYDVQQKEwZ0dWNvd3MxCzAJBgNVBAsTAnFhMR0wGwYDVQ QD ExR3d3cucWFyZWdyZXNzaW9uLm9yZzCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkC gYEAz+hbqqnE5BSW0THf7txxsJxF8Vtca2uL52iutI1SRTm9J6NNtAjgMbL9upOm SFnObpWKriUIlvxKrecygGWkjiMeyU/F6auAS9/vwDdxYEVT2szK+Q2At1FgU433 Pds53v2J/vyB6SL+k/w54H2gF4ORpU1hjUggo7fM353TeeMCAwEAAaAAMA0GCSqG SIb3DQEBBAUAA4GBAIYvVThVeocN7N7HbsO/au9AXnx6LULQ5LMDWx6FlyBB5g9h 5HYZa6xieYCYDxYIsjLjR3qx1BWl9+0kSL2MW4EdDPzbcrZvHAtrw2/hPrm9EGA3 2w3a26W79N3clCkrahnpcNFLFyzU3CtZASJ+VuixGXTEkdiBAliqtGp+QBhf -----END CERTIFICATE REQUEST-----'
        # User.create!({name: "aseleznov", signature: "2e5e7688aba0879ad1d6b48c724af427"})
      end

      def get_renew_ssl
        server_local.call(
          :action => "SW_REGISTER",
          :object => "TRUST_SERVICE"
        )
      end

      def get_renew_ssl_an_order_to_upgrade_a_sitelock_ssl_certificate_to_sitelock_premium
        server_local.call(
          :action => "SW_REGISTER",
          :object => "TRUST_SERVICE",
          :attributes => {
            :reg_type => 'upgrade'
          }
        )
      end

      def get_renew_ssl_a_new_order_for_a_quickssl_certificate_based_on_an_existing_order
        server_local.call(
          :action => "SW_REGISTER",
          :object => "TRUST_SERVICE",
          :attributes => {
            :reg_type => 'new',
            :product_type => 'quickssl'
          }
        )
      end

      def get_renew_ssl_an_order_for_a_30_day_free_trial_of_a_symantec_securesite_certificate
        server_local.call(
          :action => "SW_REGISTER",
          :object => "TRUST_SERVICE",
          :attributes => {
            :reg_type => 'new',
            :product_type => 'securesite_ft'
          }
        )
      end

      def get_renew_ssl_an_order_for_a_geotrust_web_site_anti_malware_scan_certificate
        server_local.call(
          :action => "SW_REGISTER",
          :object => "TRUST_SERVICE",
          :attributes => {
            :reg_type => 'new',
            :product_type => 'malwarescan'
          }
        )
      end



      def get_renew_ssl_a_renewal_order_for_a_quickssl_certificate_that_was_submitted_by_using_the_order_id(order_id)
        server_local.call(
          :action => "SW_REGISTER",
          :object => "TRUST_SERVICE",
          :attributes => {
            :reg_type => 'renew',
            :order_id => order_id
          }
        )
      end

      def get_renew_ssl_a_renewal_order_for_a_quickssl_certificate_that_was_submitted_by_using_the_product_id(inventory_item_id)
        server_local.call(
          :action => "SW_REGISTER",
          :object => "TRUST_SERVICE",
          :attributes => {
            :reg_type => 'renew',
            :inventory_item_id => inventory_item_id
          }
        )
      end

      def get_renew_ssl_renewal_order_for_a_quickssl_certificate(product_id)
        server_local.call(
          :action => "SW_REGISTER",
          :object => "TRUST_SERVICE",
          :attributes => {
            :reg_type => 'renew',
            :product_id => product_id
          }
        )
      end


      it "request body get_renew_ssl_an_order_to_upgrade_a_sitelock_ssl_certificate_to_sitelock_premium is correct" do
        xml_request_renew_ssl = File.read(File.join(Rails.root, 'spec','api','v2','patterns','renew_ssl','request_an_order_to_upgrade_a_sitelock_ssl_certificate_to_sitelock_premium.xml'))
        get_renew_ssl_an_order_to_upgrade_a_sitelock_ssl_certificate_to_sitelock_premium.request_xml.should == xml_request_renew_ssl
      end

      it "request body get_renew_ssl_a_new_order_for_a_quickssl_certificate_based_on_an_existing_order is correct" do
        xml_request_renew_ssl = File.read(File.join(Rails.root, 'spec','api','v2','patterns','renew_ssl','request_a_new_order_for_a_quickssl_certificate_based_on_an_existing_order.xml'))
        get_renew_ssl_a_new_order_for_a_quickssl_certificate_based_on_an_existing_order.request_xml.should == xml_request_renew_ssl
      end

      it "request body get_renew_ssl_an_order_for_a_30_day_free_trial_of_a_symantec_securesite_certificate is correct" do
        xml_request_renew_ssl = File.read(File.join(Rails.root, 'spec','api','v2','patterns','renew_ssl','request_an_order_for_a_30_day_free_trial_of_a_symantec_securesite_certificate.xml'))
        get_renew_ssl_an_order_for_a_30_day_free_trial_of_a_symantec_securesite_certificate.request_xml.should == xml_request_renew_ssl
      end

      it "request body get_renew_ssl_an_order_for_a_geotrust_web_site_anti_malware_scan_certificate is correct" do
        xml_request_renew_ssl = File.read(File.join(Rails.root, 'spec','api','v2','patterns','renew_ssl','request_an_order_for_a_geotrust_web_site_anti_malware_scan_certificate.xml'))
        get_renew_ssl_an_order_for_a_geotrust_web_site_anti_malware_scan_certificate.request_xml.should == xml_request_renew_ssl
      end

      it "request body get_renew_ssl_a_renewal_order_for_a_quickssl_certificate_that_was_submitted_by_using_the_order_id is correct" do
        xml_request_renew_ssl = File.read(File.join(Rails.root, 'spec','api','v2','patterns','renew_ssl','request_a_renewal_order_for_a_quickssl_certificate_that_was_submitted_by_using_the_order_id.xml'))
        get_renew_ssl_a_renewal_order_for_a_quickssl_certificate_that_was_submitted_by_using_the_order_id('123321').request_xml.should == xml_request_renew_ssl
      end

      it "order_id is 123321" do
        opensrs_request = OpenSRSRequest.new(get_renew_ssl_a_renewal_order_for_a_quickssl_certificate_that_was_submitted_by_using_the_order_id('123321').request_xml).request_hash
        opensrs_request["order_id"].should == "123321"
      end

      it "request body get_renew_ssl_a_renewal_order_for_a_quickssl_certificate_that_was_submitted_by_using_the_product_id is correct" do
        xml_request_renew_ssl = File.read(File.join(Rails.root, 'spec','api','v2','patterns','renew_ssl','request_a_renewal_order_for_a_quickssl_certificate_that_was_submitted_by_using_the_product_id.xml'))
        get_renew_ssl_a_renewal_order_for_a_quickssl_certificate_that_was_submitted_by_using_the_product_id('384972').request_xml.should == xml_request_renew_ssl
      end

      it "inventory_item_id is 384972" do
        opensrs_request = OpenSRSRequest.new(get_renew_ssl_a_renewal_order_for_a_quickssl_certificate_that_was_submitted_by_using_the_product_id('384972').request_xml).request_hash
        opensrs_request["inventory_item_id"].should == "384972"
      end

      it "request body get_renew_ssl_renewal_order_for_a_quickssl_certificate is correct" do
        xml_request_renew_ssl = File.read(File.join(Rails.root, 'spec','api','v2','patterns','renew_ssl','request_renewal_order_for_a_quickssl_certificate.xml'))
        get_renew_ssl_renewal_order_for_a_quickssl_certificate('384972').request_xml.should == xml_request_renew_ssl
      end

      it "product_id is 87328957" do
        opensrs_request = OpenSRSRequest.new(get_renew_ssl_renewal_order_for_a_quickssl_certificate('87328957').request_xml).request_hash
        opensrs_request["product_id"].should == "87328957"
      end

      it "username is correct"
      it "signature is correct"
      it "authorization is correct"


      it "action is SW_REGISTER" do
        opensrs_request = OpenSRSRequest.new(get_renew_ssl.request_xml).request_hash
        opensrs_request["action"].should == "SW_REGISTER"
      end

      it "object is TRUST_SERVICE" do
        opensrs_request = OpenSRSRequest.new(get_renew_ssl.request_xml).request_hash
        opensrs_request["object"].should == "TRUST_SERVICE"
      end

    end

  end


  describe "Renew SSL response" do

    context "response is correct" do

      it "response is OK"
      it "body is correct"
      it "owner is correct"

    end

  end


end
