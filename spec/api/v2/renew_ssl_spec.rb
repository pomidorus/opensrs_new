#encoding: utf-8
require "spec_helper"
require 'opensrs'

describe "/opensrs" do

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

  before(:all) do
    @csr = '-----BEGIN CERTIFICATE REQUEST----- MIIBqTCCARICAQAwaTELMAkGA1UEBhMCQ0ExCzAJBgNVBAgTAm9uMRAwDgYDVQ QH Ewd0b3JvbnRvMQ8wDQYDVQQKEwZ0dWNvd3MxCzAJBgNVBAsTAnFhMR0wGwYDVQ QD ExR3d3cucWFyZWdyZXNzaW9uLm9yZzCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkC gYEAz+hbqqnE5BSW0THf7txxsJxF8Vtca2uL52iutI1SRTm9J6NNtAjgMbL9upOm SFnObpWKriUIlvxKrecygGWkjiMeyU/F6auAS9/vwDdxYEVT2szK+Q2At1FgU433 Pds53v2J/vyB6SL+k/w54H2gF4ORpU1hjUggo7fM353TeeMCAwEAAaAAMA0GCSqG SIb3DQEBBAUAA4GBAIYvVThVeocN7N7HbsO/au9AXnx6LULQ5LMDWx6FlyBB5g9h 5HYZa6xieYCYDxYIsjLjR3qx1BWl9+0kSL2MW4EdDPzbcrZvHAtrw2/hPrm9EGA3 2w3a26W79N3clCkrahnpcNFLFyzU3CtZASJ+VuixGXTEkdiBAliqtGp+QBhf -----END CERTIFICATE REQUEST-----'
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
        :reg_type => 'upgrade',
        :product_type => "sitelock_premium",
        :period => 1,
        :product_id => 47811,
        :handle => "process",
        :special_instructions => "none",
        :contact_set => "Contact Set",
      }
    )
  end


  def get_renew_ssl_a_new_order_for_a_quickssl_certificate_based_on_an_existing_order
    server_local.call(
      :protocol => 'XCP',
      :action => "SW_REGISTER",
      :object => "TRUST_SERVICE",
      :attributes => {
        :reg_type => 'new',
        :product_type => 'quickssl',
        :handle => 'process',
        :csr => @csr,
        :base_order_id => 8245,
        :contact_set => {
          :admin => {
            :first_name => 'Adler',
            :last_name => 'Adams',
            :title => 'Admin',
            :org_name => 'Example Inc.',
            :address1 => '32 Oak Street',
            :address2 => 'Suite 100',
            :address3 => '',
            :city => 'Santa Clara',
            :state => 'CA',
            :country => 'US',
            :postal_code => 90210,
            :fax => '+1.4165350155',
            :phone => '+1.4165550123x1812',
            :email => 'adams@example.com'
          }
        }
      }
    )
  end

  def get_renew_ssl_an_order_for_a_30_day_free_trial_of_a_symantec_securesite_certificate
    server_local.call(
      :action => "SW_REGISTER",
      :object => "TRUST_SERVICE",
      :attributes => {
        :reg_type => 'new',
        :product_type => 'securesite_ft',
        :special_instructions => "none",
        :csr => "-----BEGIN CERTIFICATE REQUEST----- MIIC1zCCAb8CAQAwgZExHjAcBgNVBAMTFTEzMjA3MDU2NzN0ZXN0aW5nLmNvbTEL MAkGA1UEBhMCQ0ExEDAOBgNVBAgTB09udGFyaW8xEDAOBgNVBAcTB1Rvcm9udG 8x DzANBgNVBAoTBlR1Y293czELMAkGA1UECxMCUUExIDAeBgkqhkiG9w0BCQEWEXFh Zml2ZUB0dWNvd3MuY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA vfz5BS7X70AFyqvk05RSe5dsxB8e0aTVkj8YixqPULcMxcNSos/hF9CkWKyYD2iPg8O511Gzw3VA+TWDp+Een1HCyW1uRnnQ/Yepq0J0H4a0kPXh5Mb01WxGVwD5zor m1QM0gqIW8KTPgUCfi0P+CQkw5TZ2yqJWjcyNwakv/seg2opqUra06jkcdCDliGkW RJfGgJPM1B2fonduruveWDvIiga3+sbfAoBKajX71NgHZtQXZgHZLU2obPU1lvms ZUZGavARcUVt043sJvgZG9xMX8hf0LoT4BLrJ1TK7JWf5Be5ZAkq0Y42Lf1V198/ JKNeMJHPeTvpxkrT0W/R4wIDAQABoAAwDQYJKoZIhvcNAQEEBQADggEBAIqzgz3z 5JzscIq6XszzrJw79ampGPSz7JE35pjoPAjk7vsjbxnRTAVfLHeSMyjXTFBZB60h lyFO0Ft4KQ8Fj7eKtCoMR2mvhx1UtaoRqJ9y9RJmTJfHmdfHrNa4hLIQqDreE5Tj U4ngidNTTc91qaRrPhAC471BAn7/Ob+ltleIiUuk/ySkh29lR5qQqSTX0FXjsVrN G9gIHn4KAra3W+SgWGJHpVQrCWqqyPDQ7/dj6x1pEli8izkZv33Xw6386nFhSkB0 EH2LCtmzTJNgUicXzbRu4/UXgMJgaFU77fCzCtOBwMTz+ALWIo0NTPwNp5JE/dw0 /GOjMZgid2nuuMY=-----END CERTIFICATE REQUEST-----",
        :reg_type => "new",
        :period => 1,
        :product_type => "securesite_ft",
        :server_type => "apachessl",
        :contact_set => "Contact Set",
        :handle => "process",
        :server_count => 1,
        :approver_email => "admin@example.org",
      }
    )
  end

  def get_renew_ssl_an_order_for_a_geotrust_web_site_anti_malware_scan_certificate
    server_local.call(
      :action => "SW_REGISTER",
      :object => "TRUST_SERVICE",
      :attributes => {
        :reg_type => 'new',
        :product_type => 'malwarescan',
        :domain => "example.com",
        :product_type => "malwarescan",
        :reg_type => "new",
        :period => 1,
        :handle => "process",
        :contact_set => "Contact Set"
      }
    )
  end


  def get_renew_ssl_a_renewal_order_for_a_quickssl_certificate_that_was_submitted_by_using_the_order_id(order_id)
    server_local.call(
      :action => "SW_REGISTER",
      :object => "TRUST_SERVICE",
      :attributes => {
        :reg_type => 'renew',
        :order_id => order_id,
        :csr => @csr,
        :handle => "process",
        :product_type => "quickssl",
      }
    )
  end

  def get_renew_ssl_a_renewal_order_for_a_quickssl_certificate_that_was_submitted_by_using_the_product_id(inventory_item_id)
    server_local.call(
      :action => "SW_REGISTER",
      :object => "TRUST_SERVICE",
      :attributes => {
        :reg_type => 'renew',
        :inventory_item_id => inventory_item_id,
        :csr => @csr,
        :handle => "process",
        :product_type => "quickssl",
        :contact_set => {
          :admin => {
            :first_name => "Adler",
            :last_name => "Adams",
            :title => "Administrator",
            :org_name => "Example Co.",
            :address1 => "32 Oak Street",
            :address2 => "Suite 100",
            :address3 => nil,
            :city => "Santa Clara",
            :state => "CA",
            :country => "US",
            :postal_code => "90210",
            :fax => "+1.4165550125",
            :phone => "+1.4165550123x1812",
            :email => "adams@example.com"
          }
        }
      }
    )
  end

  def get_renew_ssl_renewal_order_for_a_quickssl_certificate(product_id)
    server_local.call(
      :action => "SW_REGISTER",
      :object => "TRUST_SERVICE",
      :attributes => {
        :reg_type => 'renew',
        :product_id => product_id,
        :handle => "process",
        :domain => "www.example.com",
        :period => 1,
        :product_type => "quickssl",
        :server_type => "apacheopenssl",
        :approver_email => "admin@example.com",
        :contact_set => "Contact Set",
        :csr => @csr,
        :special_instructions => nil
      }
    )
  end


  describe "Renew SSL request" do

    context "request is correct" do

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
        opensrs_request = OpenSRSRequestParse.new(get_renew_ssl_a_renewal_order_for_a_quickssl_certificate_that_was_submitted_by_using_the_order_id('123321').request_xml).request_hash
        opensrs_request["order_id"].should == "123321"
      end

      it "request body get_renew_ssl_a_renewal_order_for_a_quickssl_certificate_that_was_submitted_by_using_the_product_id is correct" do
        xml_request_renew_ssl = File.read(File.join(Rails.root, 'spec','api','v2','patterns','renew_ssl','request_a_renewal_order_for_a_quickssl_certificate_that_was_submitted_by_using_the_product_id.xml'))
        get_renew_ssl_a_renewal_order_for_a_quickssl_certificate_that_was_submitted_by_using_the_product_id('384972').request_xml.should == xml_request_renew_ssl
      end

      it "inventory_item_id is 384972" do
        opensrs_request = OpenSRSRequestParse.new(get_renew_ssl_a_renewal_order_for_a_quickssl_certificate_that_was_submitted_by_using_the_product_id('384972').request_xml).request_hash
        opensrs_request["inventory_item_id"].should == "384972"
      end

      it "request body get_renew_ssl_renewal_order_for_a_quickssl_certificate is correct" do
        xml_request_renew_ssl = File.read(File.join(Rails.root, 'spec','api','v2','patterns','renew_ssl','request_renewal_order_for_a_quickssl_certificate.xml'))
        get_renew_ssl_renewal_order_for_a_quickssl_certificate('384972').request_xml.should == xml_request_renew_ssl
      end

      it "product_id is 87328957" do
        opensrs_request = OpenSRSRequestParse.new(get_renew_ssl_renewal_order_for_a_quickssl_certificate('87328957').request_xml).request_hash
        opensrs_request["product_id"].should == "87328957"
      end

      it "username is correct"
      it "signature is correct"
      it "authorization is correct"


      it "action is SW_REGISTER" do
        opensrs_request = OpenSRSRequestParse.new(get_renew_ssl.request_xml).request_hash
        opensrs_request["action"].should == "SW_REGISTER"
      end

      it "object is TRUST_SERVICE" do
        opensrs_request = OpenSRSRequestParse.new(get_renew_ssl.request_xml).request_hash
        opensrs_request["object"].should == "TRUST_SERVICE"
      end

    end

  end


  describe "Renew SSL response" do

    context "response is correct" do

      it "response is OK" do
        get_renew_ssl_renewal_order_for_a_quickssl_certificate('384972').response["response_code"].to_i.should equal(200)
      end

      it "response body get_renew_ssl_an_order_to_upgrade_a_sitelock_ssl_certificate_to_sitelock_premium is correct" do
        xml_response_renew_ssl = File.read(File.join(Rails.root, 'spec','api','v2','patterns','renew_ssl','response_an_order_to_upgrade_a_sitelock_ssl_certificate_to_sitelock_premium.xml'))
        get_renew_ssl_an_order_to_upgrade_a_sitelock_ssl_certificate_to_sitelock_premium.response_xml.should == xml_response_renew_ssl
      end


      it "response body get_renew_ssl_a_new_order_for_a_quickssl_certificate_based_on_an_existing_order is correct" do
        xml_response_renew_ssl = File.read(File.join(Rails.root, 'spec','api','v2','patterns','renew_ssl','response_a_new_order_for_a_quickssl_certificate_based_on_an_existing_order.xml'))
        get_renew_ssl_a_new_order_for_a_quickssl_certificate_based_on_an_existing_order.response_xml.should == xml_response_renew_ssl
      end

      it "response body get_renew_ssl_an_order_for_a_30_day_free_trial_of_a_symantec_securesite_certificate is correct" do
        xml_response_renew_ssl = File.read(File.join(Rails.root, 'spec','api','v2','patterns','renew_ssl','response_an_order_for_a_30_day_free_trial_of_a_symantec_securesite_certificate.xml'))
        get_renew_ssl_an_order_for_a_30_day_free_trial_of_a_symantec_securesite_certificate.response_xml.should == xml_response_renew_ssl
      end

      it "response body get_renew_ssl_an_order_for_a_geotrust_web_site_anti_malware_scan_certificate is correct" do
        xml_response_renew_ssl = File.read(File.join(Rails.root, 'spec','api','v2','patterns','renew_ssl','response_an_order_for_a_geotrust_web_site_anti_malware_scan_certificate.xml'))
        get_renew_ssl_an_order_for_a_geotrust_web_site_anti_malware_scan_certificate.response_xml.should == xml_response_renew_ssl
      end


      it "response body get_renew_ssl_a_renewal_order_for_a_quickssl_certificate_that_was_submitted_by_using_the_order_id is correct" do
        xml_response_renew_ssl = File.read(File.join(Rails.root, 'spec','api','v2','patterns','renew_ssl','response_a_renewal_order_for_a_quickssl_certificate_that_was_submitted_by_using_the_order_id.xml'))
        get_renew_ssl_a_renewal_order_for_a_quickssl_certificate_that_was_submitted_by_using_the_order_id('123321').response_xml.should == xml_response_renew_ssl
      end

      it "response body get_renew_ssl_a_renewal_order_for_a_quickssl_certificate_that_was_submitted_by_using_the_product_id is correct" do
        xml_response_renew_ssl = File.read(File.join(Rails.root, 'spec','api','v2','patterns','renew_ssl','response_a_renewal_order_for_a_quickssl_certificate_that_was_submitted_by_using_the_product_id.xml'))
        get_renew_ssl_a_renewal_order_for_a_quickssl_certificate_that_was_submitted_by_using_the_product_id('384972').response_xml.should == xml_response_renew_ssl
      end

      it "response body get_renew_ssl_renewal_order_for_a_quickssl_certificate is correct" do
        xml_response_renew_ssl = File.read(File.join(Rails.root, 'spec','api','v2','patterns','renew_ssl','response_renewal_order_for_a_quickssl_certificate.xml'))
        get_renew_ssl_renewal_order_for_a_quickssl_certificate('384972').response_xml.should == xml_response_renew_ssl
      end

      xit "owner is correct" do
      end

    end

  end


end
