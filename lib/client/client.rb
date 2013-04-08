require 'opensrs'
require 'libxml'


class OpenSRSRequest
  attr :server, :username, :password, :key

  def initialize(server,username,password,key)
    OpenSRS::Server.xml_processor = :libxml
    @server, @username, @password, @key = server, username, password, key
  end

  # init remote server
  def remote_server
    OpenSRS::Server.new(
      :server   => server,
      :username => username,
      :password => password,
      :key      => key
    )
  end

  # request api with parameters
  def request_api(action,object,attributes,registrant_ip="")
    remote_server.call(
          :action => action,
          :object => object,
          :registrant_ip => registrant_ip,
          :attributes => attributes
        )
  end

end

opensrs_request = OpenSRSRequest.new("http://localhost:3000/opensrs2","aseleznov","53cr3t","c633be3170c7fb3fb29e2f99b84be2410")
#opensrs_request = OpenSRSRequest.new("http://opensrs.herokuapp.com/opensrs","aseleznov","53cr3t","c633be3170c7fb3fb29e2f99b84be2410")

#For a .RU domain order
action = "GET_ORDER_INFO"
object = "DOMAIN"
attributes = { order_id: '123746'}
api = opensrs_request.request_api(action,object,attributes)
puts "------GET_ORDER_INFO---------------------------------------"
puts api.request_xml
puts api.response_xml
#
#

##Retrieves the properties for a Trust Service product.
action = "GET_PRODUCT_INFO"
object = "TRUST_SERVICE"
attributes = { product_id: '123746' }
api = opensrs_request.request_api(action,object,attributes)
puts "------GET_PRODUCT_INFO---------------------------------------"
puts api.request_xml
puts api.response_xml

##Retrieves all information for a Trust Service product.
action = "GET_PRODUCT_INFO"
object = "TRUST_SERVICE"
attributes = { product_id: '123746', all_info: 1 }
api = opensrs_request.request_api(action,object,attributes)
puts "------GET_PRODUCT_INFO_ALL---------------------------------------"
puts api.request_xml
puts api.response_xml
###
###

action = "QUERY_APPROVER_LIST"
object = "TRUST_SERVICE"
attributes = { domain: 'www.mail.ru', product_type: "quickssl" }
api = opensrs_request.request_api(action,object,attributes)
puts "------QUERY_APPROVER_LIST---------------------------------------"
puts api.request_xml
puts api.response_xml
##
##

action = "RESEND_APPROVE_EMAIL"
object = "TRUST_SERVICE"
attributes = { order_id: '123432' }
api = opensrs_request.request_api(action,object,attributes)
puts "------RESEND_APPROVE_EMAIL---------------------------------------"
puts api.request_xml
puts api.response_xml
##
##
action = "RESEND_CERT_EMAIL"
object = "TRUST_SERVICE"
attributes = { order_id: '12' }
api = opensrs_request.request_api(action,object,attributes)
puts "------RESEND_CERT_EMAIL---------------------------------------"
puts api.request_xml
puts api.response_xml
#
action = "CANCEL_ORDER"
object = "TRUST_SERVICE"
attributes = { order_id: '12' }
api = opensrs_request.request_api(action,object,attributes)
puts "------CANCEL_ORDER---------------------------------------"
puts api.request_xml
puts api.response_xml

#
sslcert = %q(-----BEGIN CERTIFICATE REQUEST----- MIIBqTCCARICAQAwaTELMAkGA1UEBhMCQ0ExCzAJBgNVBAgTAm9uMRAwDgYDVQQH
Ewd0b3JvbnRvMQ8wDQYDVQQKEwZ0dWNvd3MxCzAJBgNVBAsTAnFhMR0wGwYDVQQD
ExR3d3cucWFyZWdyZXNzaW9uLm9yZzCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkC
gYEAz+hbqqnE5BSW0THf7txxsJxF8Vtca2uL52iutI1SRTm9J6NNtAjgMbL9upOm
SFnObpWKriUIlvxKrecygGWkjiMeyU/F6auAS9/vwDdxYEVT2szK+Q2At1FgU433
Pds53v2J/vyB6SL+k/w54H2gF4ORpU1hjUggo7fM353TeeMCAwEAAaAAMA0GCSqG
SIb3DQEBBAUAA4GBAIYvVThVeocN7N7HbsO/au9AXnx6LULQ5LMDWx6FlyBB5g9h
5HYZa6xieYCYDxYIsjLjR3qx1BWl9+0kSL2MW4EdDPzbcrZvHAtrw2/hPrm9EGA3
2w3a26W79N3clCkrahnpcNFLFyzU3CtZASJ+VuixGXTEkdiBAliqtGp+QBhf -----END
CERTIFICATE REQUEST-----)

action = "PARSE_CSR"
object = "TRUST_SERVICE"
attributes = { product_type: 'quickssl', csr: sslcert }
api = opensrs_request.request_api(action,object,attributes)
puts "------PARSE_CSR---------------------------------------"
puts api.request_xml
puts api.response_xml
#
#

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

test_contact_set =  {
    admin: CONTACT,
    tech: CONTACT,
    organization: CONTACT,
    billing: CONTACT
  }


#--------------------------------------------------------------------

action = "SW_REGISTER"
object = "DOMAIN"
registrant_ip = "192.168.0.1"
attributes = {
  order_id: '333',
  contact_set: test_contact_set,
  custom_nameservers: '1',
  reg_type: 'new',
  reg_password: 'test',
  reg_username: 'aseleznov',
  domain: 'www.mail.ru',
  custom_tech_contact: '0'
}
api = opensrs_request.request_api(action,object,attributes,registrant_ip)
puts "------SW_REGISTER NEW DOMAIN---------------------------------------"
puts api.request_xml
puts api.response_xml
#

#This example shows an order for a Symantec SecureSite certificate with seal-in-search and trust seal.
action = "SW_REGISTER"
object = "TRUST_SERVICE"
registrant_ip = "192.168.0.1"
attributes = {
  handle: "process",
  reg_type: "new",
  product_type: "securesite",
  contact_set: test_contact_set,

  trust_seal: "1",
  seal_in_search: "1",
  special_instructions: "Test ABC",
  csr: "-----BEGIN CERTIFICATE REQUEST----- MIIC4TCCAckCAQAwgZsxKTAnBgNVBAMTIHNlY3VyZXNpdGUudGVzdDEyODU4NzYwMzY2MDgub3JnMQswCQYDVQQGEwJDQTELMAkGA1UECBMCT04xEDAOBgNVBAcTB1Rvcm9udG8xDzANBgNVBAoTBm5ld29yZzEPMA0GA1UECxMGUUFEZXB0MSAwHgYJKoZIhvcNAQkBFhFxYWZpdmVAdHVjb3dzLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAJ0FDLurKaddUzayM5FgICBhy8DkOaBuYzCiHSFw6xRUf9CjAHpC/MiUM5TnegMiU02COAPmfeHZAERv21CoB/HPDcshewHJywzs8nwcbGncz37eFhNGFQNIif5ExoGAcLS9+d1EAmR1CupTBCCq86lGBa/RdwgUNlvLF5IgZZeKphd/FKaYB2KZmRBxM51WvV6AYmRKb6IsuUZCfHO2FCelThDE0EF99GbfSapVj7woSIu0/PTJcEX4sHURq6pY3ELfNG0BOzrTsT3Af8T3N5xwD0FMatkDrCPCgVx7sRZ05UqenxBOVWBJQcr5QRZSykxBosGjbqO3QSyGsElIKgkCAwEAAaAAMA0GCSqGSIb3DQEBBAUAA4IBAQCEUGNk45qCJiR4Yuce4relbP22EwK7pyX0+0VZ+F3eUxhpZ6S5WN1Juuru8w48RchQBjGK1jjUfXJIqn/DgX+yAfMj4aW/ohBmovN2ViuNILvNaj0volwoqyMlNrTmBze69qHMfnMGUUUehMr/Nq4QdQTqxy7EYQkNOqx21gfZcUi6zWCeFTRkasD+SYAKsOUIKdrt/Jq5lWFXxhkJHuyA+q1yr/w6zh18JmFAT4y/0q/odFGyIr9yKhQ9usW1sQ8CT3e3AnU4jq7sBrYFxN0f+92W8gX7WADortA7+6PcSFPrZEoQlr5Brki7GSwIuTTSlKFRyZ53DbEGjp2ELnnl -----END CERTIFICATE REQUEST----- ",
  period: "1",
  server_type: "apachessl",
  server_count: "1"
}
api = opensrs_request.request_api(action,object,attributes,registrant_ip)
puts "------SW_REGISTER NEW TRUST_SERVICE---------------------------------------"
puts api.request_xml
puts api.response_xml
#


#This example shows a renewal order for a QuickSSL certificate.
action = "SW_REGISTER"
object = "TRUST_SERVICE"
registrant_ip = "192.168.0.1"
attributes = {
  handle: "process",
  reg_type: "renew",
  product_type: "quickssl",
  contact_set: test_contact_set,

  approver_email: "admin@example.com",
  special_instructions: "",
  product_id: "2342",
  domain: 'www.mail.ru',
  csr: "-----BEGIN CERTIFICATE REQUEST----- MIIC4TCCAckCAQAwgZsxKTAnBgNVBAMTIHNlY3VyZXNpdGUudGVzdDEyODU4NzYwMzY2MDgub3JnMQswCQYDVQQGEwJDQTELMAkGA1UECBMCT04xEDAOBgNVBAcTB1Rvcm9udG8xDzANBgNVBAoTBm5ld29yZzEPMA0GA1UECxMGUUFEZXB0MSAwHgYJKoZIhvcNAQkBFhFxYWZpdmVAdHVjb3dzLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAJ0FDLurKaddUzayM5FgICBhy8DkOaBuYzCiHSFw6xRUf9CjAHpC/MiUM5TnegMiU02COAPmfeHZAERv21CoB/HPDcshewHJywzs8nwcbGncz37eFhNGFQNIif5ExoGAcLS9+d1EAmR1CupTBCCq86lGBa/RdwgUNlvLF5IgZZeKphd/FKaYB2KZmRBxM51WvV6AYmRKb6IsuUZCfHO2FCelThDE0EF99GbfSapVj7woSIu0/PTJcEX4sHURq6pY3ELfNG0BOzrTsT3Af8T3N5xwD0FMatkDrCPCgVx7sRZ05UqenxBOVWBJQcr5QRZSykxBosGjbqO3QSyGsElIKgkCAwEAAaAAMA0GCSqGSIb3DQEBBAUAA4IBAQCEUGNk45qCJiR4Yuce4relbP22EwK7pyX0+0VZ+F3eUxhpZ6S5WN1Juuru8w48RchQBjGK1jjUfXJIqn/DgX+yAfMj4aW/ohBmovN2ViuNILvNaj0volwoqyMlNrTmBze69qHMfnMGUUUehMr/Nq4QdQTqxy7EYQkNOqx21gfZcUi6zWCeFTRkasD+SYAKsOUIKdrt/Jq5lWFXxhkJHuyA+q1yr/w6zh18JmFAT4y/0q/odFGyIr9yKhQ9usW1sQ8CT3e3AnU4jq7sBrYFxN0f+92W8gX7WADortA7+6PcSFPrZEoQlr5Brki7GSwIuTTSlKFRyZ53DbEGjp2ELnnl -----END CERTIFICATE REQUEST----- ",
  period: "1",
  server_type: "apachessl",
}
api = opensrs_request.request_api(action,object,attributes,registrant_ip)
puts "------SW_REGISTER NEW TRUST_SERVICE---------------------------------------"
puts api.request_xml
puts api.response_xml
