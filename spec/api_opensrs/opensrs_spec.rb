require 'spec_helper'
require 'sloboda_client'

describe "ApiOpenSRS" do

  let(:dir) { File.dirname(__FILE__) }

  before (:all) do
    @opensrs_request = SlobodaClient::Request.new("http://localhost:3000/opensrs","aseleznov","53cr3t","c633be3170c7fb3fb29e2f99b84be2410")
    @bad_opensrs_request = SlobodaClient::Request.new("http://localhost:3000/opensrs","sokolov","53cr3t","c633be3170c7fb3fb29e2f99b84be2410")

    CONTACT = {
      first_name: "Andrey",
      last_name: "Seleznov",
      org_name: "Example Inc.",
      address1: "32 Oak St.",
      address2: "Suite 500",
      city: "Santa Clara",
      region: "Donbass",
      country: "RU",
      postal_code: "90210",
      phone: "+1.4165550123x1902",
      fax: "+1.4165550124",
      email: "owner@example.com",
      title: "mr",
      country_id: "1"
    }

    TEST_CONTACT_SET = {
      admin: CONTACT,
      tech: CONTACT,
      organization: CONTACT,
      billing: CONTACT
    }

    SSLCERT = %q(-----BEGIN CERTIFICATE REQUEST----- MIIBqTCCARICAQAwaTELMAkGA1UEBhMCQ0ExCzAJBgNVBAgTAm9uMRAwDgYDVQQHEwd0b3JvbnRvMQ8wDQYDVQQKEwZ0dWNvd3MxCzAJBgNVBAsTAnFhMR0wGwYDVQQDExR3d3cucWFyZWdyZXNzaW9uLm9yZzCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEAz+hbqqnE5BSW0THf7txxsJxF8Vtca2uL52iutI1SRTm9J6NNtAjgMbL9upOmSFnObpWKriUIlvxKrecygGWkjiMeyU/F6auAS9/vwDdxYEVT2szK+Q2At1FgU433Pds53v2J/vyB6SL+k/w54H2gF4ORpU1hjUggo7fM353TeeMCAwEAAaAAMA0GCSqGSIb3DQEBBAUAA4GBAIYvVThVeocN7N7HbsO/au9AXnx6LULQ5LMDWx6FlyBB5g9h5HYZa6xieYCYDxYIsjLjR3qx1BWl9+0kSL2MW4EdDPzbcrZvHAtrw2/hPrm9EGA32w3a26W79N3clCkrahnpcNFLFyzU3CtZASJ+VuixGXTEkdiBAliqtGp+QBhf -----END CERTIFICATE REQUEST-----)

  end

  #------------------------------------------------------------------------
  #------------------------------------------------------------------------
  #------------------------------------------------------------------------

  context 'authorization' do
    before (:all) do
      action = "GET_ORDER_INFO"
      object = "DOMAIN"
      attributes = { order_id: '123746'}
      #For Seleznov
      @api = @opensrs_request.request_api(action,object,attributes)
      #For Sokolov
      @bad_api = @bad_opensrs_request.request_api(action,object,attributes)
    end

    it 'user Seleznov should return correct response' do
      xml_response = open("#{dir}/response/get_order_info_response.xml", 'r').readlines.join
      @api.response_xml.should eql(xml_response)
    end

    it 'user Sokolov should return bad_auth response' do
      xml_response = open("#{dir}/response/bad_authorization_response.xml", 'r').readlines.join
      @bad_api.response_xml.should eql(xml_response)
    end
  end

  #------------------------------------------------------------------------
  #------------------------------------------------------------------------
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
      xml_request = open("#{dir}/request/get_order_info_request.xml", 'r').readlines.join
      @api.request_xml.should  eql(xml_request)
    end

    it 'response should be correct' do
      xml_response = open("#{dir}/response/get_order_info_response.xml", 'r').readlines.join
      @api.response_xml.should eql(xml_response)
    end

    it 'Product ID should be present' do
      @api.response["attributes"]["field_hash"]["id"].should_not eql(nil)
    end

    it 'Product ID should not be empty' do
      @api.response["attributes"]["field_hash"]["id"].empty?.should_not be_true
    end
  end

  #------------------------------------------------------------------------
  #------------------------------------------------------------------------
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
      xml_request = open("#{dir}/request/get_product_info_request.xml", 'r').readlines.join
      @api.request_xml.should  eql(xml_request)
    end

    it 'response should be correct' do
      xml_response = open("#{dir}/response/get_product_info_response.xml", 'r').readlines.join
      @api.response_xml.should eql(xml_response)
    end
  end

  #------------------------------------------------------------------------
  #------------------------------------------------------------------------
  #------------------------------------------------------------------------

  context 'GET_PRODUCT_INFO_ALL' do
    before (:all) do
      ##Retrieves all information for a Trust Service product.
      action = "GET_PRODUCT_INFO"
      object = "TRUST_SERVICE"
      attributes = { product_id: '123746', all_info: 1 }
      @api = @opensrs_request.request_api(action,object,attributes)
    end

    it 'request should be correct' do
      xml_request = open("#{dir}/request/get_product_info_all_request.xml", 'r').readlines.join
      @api.request_xml.should  eql(xml_request)
    end

    it 'response should be correct' do
      xml_response = open("#{dir}/response/get_product_info_all_response.xml", 'r').readlines.join
      @api.response_xml.should  eql(xml_response)
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
  #------------------------------------------------------------------------
  #------------------------------------------------------------------------

  #Query a list of approver email addresses allowed for the domain to which the request's approval email will be sent
  context 'QUERY_APPROVER_LIST' do
    before (:all) do
      action = "QUERY_APPROVER_LIST"
      object = "TRUST_SERVICE"
      attributes = { domain: 'www.mail.ru', product_type: "quickssl" }
      @api = @opensrs_request.request_api action, object, attributes
    end

    it 'request should be correct' do
      xml_request = open("#{dir}/request/query_list_request.xml", 'r').readlines.join
      @api.request_xml.should  eql(xml_request)
    end

    it 'response should be correct' do
      xml_response = open("#{dir}/response/query_list_response.xml", 'r').readlines.join
      @api.response_xml.should  eql(xml_response)
    end
  end

  #------------------------------------------------------------------------
  #------------------------------------------------------------------------
  #------------------------------------------------------------------------

  #Request the approval email be re-sent based on an Order ID
  context 'RESEND_APPROVE_EMAIL' do
    before (:all) do
      action = "RESEND_APPROVE_EMAIL"
      object = "TRUST_SERVICE"
      attributes = { order_id: '123432' }
      @api = @opensrs_request.request_api action, object, attributes
    end

    it 'request should be correct' do
      xml_request = open("#{dir}/request/resend_approve_email_request.xml", 'r').readlines.join
      @api.request_xml.should  eql(xml_request)
    end

    it 'response should be correct' do
      xml_response = open("#{dir}/response/resend_approve_email_response.xml", 'r').readlines.join
      @api.response_xml.should  eql(xml_response)
    end
  end

  #------------------------------------------------------------------------
  #------------------------------------------------------------------------
  #------------------------------------------------------------------------

  #Request the certificate email be re-sent based on an Order ID
  context 'RESEND_CERT_EMAIL' do
    before (:all) do
      action = "RESEND_CERT_EMAIL"
      object = "TRUST_SERVICE"
      attributes = { order_id: '12' }
      @api = @opensrs_request.request_api action, object, attributes
    end

    it 'request should be correct' do
      xml_request = open("#{dir}/request/resend_cert_email_request.xml", 'r').readlines.join
      @api.request_xml.should  eql(xml_request)
    end

    it 'response should be correct' do
      xml_response = open("#{dir}/response/resend_cert_email_response.xml", 'r').readlines.join
      @api.response_xml.should  eql(xml_response)
    end
  end

  #------------------------------------------------------------------------
  #------------------------------------------------------------------------
  #------------------------------------------------------------------------

  #A request can only be cancelled if the order is in progress. It can not be canceled after the order has completed
  context 'CANCEL_ORDER' do
    before (:all) do
      action = "CANCEL_ORDER"
      object = "TRUST_SERVICE"
      attributes = { order_id: '12' }
      @api = @opensrs_request.request_api action, object, attributes
    end

    it 'request should be correct' do
      xml_request = open("#{dir}/request/cancel_order_request.xml", 'r').readlines.join
      @api.request_xml.should  eql(xml_request)
    end

    it 'response should be correct' do
      xml_response = open("#{dir}/response/cancel_order_response.xml", 'r').readlines.join
      @api.response_xml.should  eql(xml_response)
    end
  end

  #------------------------------------------------------------------------
  #------------------------------------------------------------------------
  #------------------------------------------------------------------------

  #Parse the CSR submitted by the user to present them back the configured values to then finally confirm and process their request
  context 'PARSE_CSR' do
    before (:all) do
      action = "PARSE_CSR"
      object = "TRUST_SERVICE"
      attributes = { product_type: 'quickssl', csr: SSLCERT }
      @api = @opensrs_request.request_api action, object, attributes
    end

    it 'request should be correct' do
      xml_request = open("#{dir}/request/parse_csr_request.xml", 'r').readlines.join
      @api.request_xml.should  eql(xml_request)
    end

    it 'response should be correct' do
      xml_response = open("#{dir}/response/parse_csr_response.xml", 'r').readlines.join
      @api.response_xml.should  eql(xml_response)
    end
  end

  #------------------------------------------------------------------------
  #------------------------------------------------------------------------
  #------------------------------------------------------------------------

  #Submit order information for processing immediately, and obtain an Order ID
  context 'SW_REGISTER NEW DOMAIN' do
    before (:all) do
      action = "SW_REGISTER"
      object = "DOMAIN"
      registrant_ip = "192.168.0.1"
      attributes = {
        order_id: '333',
        contact_set: TEST_CONTACT_SET,
        custom_nameservers: '1',
        reg_type: 'new',
        reg_password: 'test',
        reg_username: 'aseleznov',
        domain: 'www.mail.ru',
        custom_tech_contact: '0'
      }
      @api = @opensrs_request.request_api(action,object,attributes,registrant_ip)
    end

    it 'request should be correct' do
      xml_request = open("#{dir}/request/register_new_request.xml", 'r').readlines.join
      @api.request_xml.should  eql(xml_request)
    end

    it 'response should be correct' do
      xml_response = open("#{dir}/response/register_new_response.xml", 'r').readlines.join
      @api.response_xml.should  eql(xml_response)
    end
  end

  #------------------------------------------------------------------------
  #------------------------------------------------------------------------
  #------------------------------------------------------------------------

  context 'when action is SW_REGISTER and object is TRUST_SERVICE' do
    before (:all) do
      #This example shows an order for a Symantec SecureSite certificate with seal-in-search and trust seal.
      action = "SW_REGISTER"
      object = "TRUST_SERVICE"
      registrant_ip = "192.168.0.1"
      attributes = {
        handle: "process",
        reg_type: "new",
        product_type: "securesite",
        contact_set: TEST_CONTACT_SET,

        trust_seal: "1",
        seal_in_search: "1",
        special_instructions: "Test ABC",
        csr: "-----BEGIN CERTIFICATE REQUEST----- MIIC4TCCAckCAQAwgZsxKTAnBgNVBAMTIHNlY3VyZXNpdGUudGVzdDEyODU4NzYwMzY2MDgub3JnMQswCQYDVQQGEwJDQTELMAkGA1UECBMCT04xEDAOBgNVBAcTB1Rvcm9udG8xDzANBgNVBAoTBm5ld29yZzEPMA0GA1UECxMGUUFEZXB0MSAwHgYJKoZIhvcNAQkBFhFxYWZpdmVAdHVjb3dzLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAJ0FDLurKaddUzayM5FgICBhy8DkOaBuYzCiHSFw6xRUf9CjAHpC/MiUM5TnegMiU02COAPmfeHZAERv21CoB/HPDcshewHJywzs8nwcbGncz37eFhNGFQNIif5ExoGAcLS9+d1EAmR1CupTBCCq86lGBa/RdwgUNlvLF5IgZZeKphd/FKaYB2KZmRBxM51WvV6AYmRKb6IsuUZCfHO2FCelThDE0EF99GbfSapVj7woSIu0/PTJcEX4sHURq6pY3ELfNG0BOzrTsT3Af8T3N5xwD0FMatkDrCPCgVx7sRZ05UqenxBOVWBJQcr5QRZSykxBosGjbqO3QSyGsElIKgkCAwEAAaAAMA0GCSqGSIb3DQEBBAUAA4IBAQCEUGNk45qCJiR4Yuce4relbP22EwK7pyX0+0VZ+F3eUxhpZ6S5WN1Juuru8w48RchQBjGK1jjUfXJIqn/DgX+yAfMj4aW/ohBmovN2ViuNILvNaj0volwoqyMlNrTmBze69qHMfnMGUUUehMr/Nq4QdQTqxy7EYQkNOqx21gfZcUi6zWCeFTRkasD+SYAKsOUIKdrt/Jq5lWFXxhkJHuyA+q1yr/w6zh18JmFAT4y/0q/odFGyIr9yKhQ9usW1sQ8CT3e3AnU4jq7sBrYFxN0f+92W8gX7WADortA7+6PcSFPrZEoQlr5Brki7GSwIuTTSlKFRyZ53DbEGjp2ELnnl -----END CERTIFICATE REQUEST----- ",
        period: "1",
        server_type: "apachessl",
        server_count: "1"
      }
      @api = @opensrs_request.request_api(action, object, attributes, registrant_ip)
    end

    it 'request should be correct' do
      xml_request = open("#{dir}/request/register_new_service_request.xml", 'r').readlines.join
      @api.request_xml.should  eql(xml_request)
    end

    it 'response should be correct' do
      xml_response = open("#{dir}/response/register_new_service_response.xml", 'r').readlines.join
      @api.response_xml.should  eql(xml_response)
    end
  end

  #------------------------------------------------------------------------
  #------------------------------------------------------------------------
  #------------------------------------------------------------------------

  #Request renewal of certificate using existing CSR and other information pulled from existing Order using Order ID
  context 'when action is SW_REGISTER and object is TRUST_SERVICE and reg_type is renew' do
    before (:all) do
      #This example shows a renewal order for a QuickSSL certificate.
      action = "SW_REGISTER"
      object = "TRUST_SERVICE"
      registrant_ip = "192.168.0.1"
      attributes = {
        handle: "process",
        reg_type: "renew",
        product_type: "quickssl",
        contact_set: TEST_CONTACT_SET,

        approver_email: "admin@example.com",
        special_instructions: "",
        product_id: "2342",
        domain: 'www.mail.ru',
        csr: "-----BEGIN CERTIFICATE REQUEST----- MIIC4TCCAckCAQAwgZsxKTAnBgNVBAMTIHNlY3VyZXNpdGUudGVzdDEyODU4NzYwMzY2MDgub3JnMQswCQYDVQQGEwJDQTELMAkGA1UECBMCT04xEDAOBgNVBAcTB1Rvcm9udG8xDzANBgNVBAoTBm5ld29yZzEPMA0GA1UECxMGUUFEZXB0MSAwHgYJKoZIhvcNAQkBFhFxYWZpdmVAdHVjb3dzLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAJ0FDLurKaddUzayM5FgICBhy8DkOaBuYzCiHSFw6xRUf9CjAHpC/MiUM5TnegMiU02COAPmfeHZAERv21CoB/HPDcshewHJywzs8nwcbGncz37eFhNGFQNIif5ExoGAcLS9+d1EAmR1CupTBCCq86lGBa/RdwgUNlvLF5IgZZeKphd/FKaYB2KZmRBxM51WvV6AYmRKb6IsuUZCfHO2FCelThDE0EF99GbfSapVj7woSIu0/PTJcEX4sHURq6pY3ELfNG0BOzrTsT3Af8T3N5xwD0FMatkDrCPCgVx7sRZ05UqenxBOVWBJQcr5QRZSykxBosGjbqO3QSyGsElIKgkCAwEAAaAAMA0GCSqGSIb3DQEBBAUAA4IBAQCEUGNk45qCJiR4Yuce4relbP22EwK7pyX0+0VZ+F3eUxhpZ6S5WN1Juuru8w48RchQBjGK1jjUfXJIqn/DgX+yAfMj4aW/ohBmovN2ViuNILvNaj0volwoqyMlNrTmBze69qHMfnMGUUUehMr/Nq4QdQTqxy7EYQkNOqx21gfZcUi6zWCeFTRkasD+SYAKsOUIKdrt/Jq5lWFXxhkJHuyA+q1yr/w6zh18JmFAT4y/0q/odFGyIr9yKhQ9usW1sQ8CT3e3AnU4jq7sBrYFxN0f+92W8gX7WADortA7+6PcSFPrZEoQlr5Brki7GSwIuTTSlKFRyZ53DbEGjp2ELnnl -----END CERTIFICATE REQUEST----- ",
        period: "1",
        server_type: "apachessl",
      }
      @api = @opensrs_request.request_api(action, object, attributes, registrant_ip)
    end

    it 'request should be correct' do
      xml_request = open("#{dir}/request/register_renew_service_request.xml", 'r').readlines.join
      @api.request_xml.should  eql(xml_request)
    end

    it 'request without required attribute should return correct message'

    it 'response should be correct' do
      xml_response = open("#{dir}/response/register_renew_service_response.xml", 'r').readlines.join
      @api.response_xml.should  eql(xml_response)
    end
  end


end