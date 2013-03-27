require 'opensrs'


class OpenSRSRequest
  attr :server, :username, :password, :key

  def initialize(server,username,password,key)
    OpenSRS::Server.xml_processor = :nokogiri
    @server, @username, @password, @key = server, username, password, key
  end

  def remote_server
    OpenSRS::Server.new(
      :server   => server,
      :username => username,
      :password => password,
      :key      => key
    )
  end

  #TODO: Refactor to one function

  def request_api(action,object,attributes)
    remote_server.call(
          :action => action,
          :object => object,
          :attributes => attributes
        )
  end


  #---------------------------------------------

  #def order_info(order_id)
  #  remote_server.call(
  #        :action => "GET_ORDER_INFO",
  #        :object => "DOMAIN",
  #        :attributes => {
  #          :order_id => order_id
  #        }
  #      )
  #end

  #def product_info(product_id)
  #  remote_server.call(
  #        :action => "GET_PRODUCT_INFO",
  #        :object => "TRUST_SERVICE",
  #        :attributes => {
  #          :product_id => product_id
  #        }
  #      )
  #end

  def cancel_order(order_id)
    remote_server.call(
          :action => "CANCEL_ORDER",
          :object => "TRUST_SERVICE",
          :attributes => {
            :order_id => order_id
          }
        )
  end

  def parse_csr(product_type, csr)
    remote_server.call(
          :action => "PARSE_CSR",
          :object => "TRUST_SERVICE",
          :attributes => {
            :product_type => product_type,
            :csr => csr
          }
        )
  end

  def register_ssl_cert(order_id)
    remote_server.call(
          :action => "SW_REGISTER",
          :object => "TRUST_SERVICE",
          :attributes => {
            :order_id => order_id
          }
        )
  end


  def renew_ssl(attributes)
    remote_server.call(
      :action => "SW_REGISTER",
      :object => "TRUST_SERVICE",
      :attributes => attributes
    )
  end

  def approver_list(domain, product_type)
    remote_server.call(
          :action => "QUERY_APPROVER_LIST",
          :object => "TRUST_SERVICE",
          :attributes => {
            :domain => domain,
            :product_type => product_type

          }
        )
  end

  def resend_approve_email(order_id)
    remote_server.call(
          :action => "RESEND_APPROVE_EMAIL",
          :object => "TRUST_SERVICE",
          :attributes => {
            :order_id => order_id
          }
        )
  end

  def resend_cert_email(order_id)
    remote_server.call(
          :action => "RESEND_CERT_EMAIL",
          :object => "TRUST_SERVICE",
          :attributes => {
            :order_id => order_id
          }
        )
  end

end


opensrs_request = OpenSRSRequest.new("http://localhost:3000/opensrs","aseleznov","53cr3t","c633be3170c7fb3fb29e2f99b84be2410")
#opensrs_request = OpenSRSRequest.new("http://opensrs.herokuapp.com/opensrs","aseleznov","53cr3t","c633be3170c7fb3fb29e2f99b84be2410")

#roi = opensrs_request.request_order_info("123242")
#rpi = opensrs_request.request_product_info("99")
#rco = opensrs_request.request_cancel_order("34453")
#
#sslcert = %q(-----BEGIN CERTIFICATE REQUEST----- MIIBqTCCARICAQAwaTELMAkGA1UEBhMCQ0ExCzAJBgNVBAgTAm9uMRAwDgYDVQQH
#Ewd0b3JvbnRvMQ8wDQYDVQQKEwZ0dWNvd3MxCzAJBgNVBAsTAnFhMR0wGwYDVQQD
#ExR3d3cucWFyZWdyZXNzaW9uLm9yZzCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkC
#gYEAz+hbqqnE5BSW0THf7txxsJxF8Vtca2uL52iutI1SRTm9J6NNtAjgMbL9upOm
#SFnObpWKriUIlvxKrecygGWkjiMeyU/F6auAS9/vwDdxYEVT2szK+Q2At1FgU433
#Pds53v2J/vyB6SL+k/w54H2gF4ORpU1hjUggo7fM353TeeMCAwEAAaAAMA0GCSqG
#SIb3DQEBBAUAA4GBAIYvVThVeocN7N7HbsO/au9AXnx6LULQ5LMDWx6FlyBB5g9h
#5HYZa6xieYCYDxYIsjLjR3qx1BWl9+0kSL2MW4EdDPzbcrZvHAtrw2/hPrm9EGA3
#2w3a26W79N3clCkrahnpcNFLFyzU3CtZASJ+VuixGXTEkdiBAliqtGp+QBhf -----END
#CERTIFICATE REQUEST-----)
#rpc = opensrs_request.request_parse_csr("quickssl",sslcert)
#
#rsc = opensrs_request.request_register_ssl_cert("2324434")
#
#ral =  opensrs_request.request_approver_list("www.mail.ru","quickssl")
#rsae = opensrs_request.request_resend_approve_email("1232")
#rrce = opensrs_request.request_resend_cert_email("232432")

#attributes = { reg_type: 'upgrade' }
#grs = opensrs_request.renew_ssl(attributes)
#puts "---------------------------------------------"
#puts grs.request_xml
#puts grs.response_xml

action = "SW_REGISTER"
object = "TRUST_SERVICE"
attributes = { reg_type: 'upgrade' }
api = opensrs_request.request_api(action,object,attributes)
puts "---------RENEW_SSL-----------------------------------"
puts api.request_xml
puts api.response_xml


action = "GET_ORDER_INFO"
object = "DOMAIN"
attributes = { order_id: '123746' }
api = opensrs_request.request_api(action,object,attributes)
puts "------GET_ORDER_INFO---------------------------------------"
puts api.request_xml
puts api.response_xml


action = "GET_PRODUCT_INFO"
object = "TRUST_SERVICE"
attributes = { product_id: '123746' }
api = opensrs_request.request_api(action,object,attributes)
puts "------GET_PRODUCT_INFO---------------------------------------"
puts api.request_xml
puts api.response_xml

action = "QUERY_APPROVER_LIST"
object = "TRUST_SERVICE"
attributes = { domain: 'www.mail.ru', product_type: "quickssl" }
api = opensrs_request.request_api(action,object,attributes)
puts "------QUERY_APPROVER_LIST---------------------------------------"
puts api.request_xml
puts api.response_xml

action = "RESEND_APPROVE_EMAIL"
object = "TRUST_SERVICE"
attributes = { order_id: '123432' }
api = opensrs_request.request_api(action,object,attributes)
puts "------RESEND_APPROVE_EMAIL---------------------------------------"
puts api.request_xml
puts api.response_xml


action = "RESEND_CERT_EMAIL"
object = "TRUST_SERVICE"
attributes = { order_id: '12' }
api = opensrs_request.request_api(action,object,attributes)
puts "------RESEND_CERT_EMAIL---------------------------------------"
puts api.request_xml
puts api.response_xml


#attributes = { reg_type: 'new', product_type: 'quickssl' }
#grs = opensrs_request.renew_ssl(attributes)
#puts "---------------------------------------------"
#puts grs.request_xml
#puts grs.response_xml
#
#attributes = { reg_type: 'new', product_type: 'securesite_ft' }
#grs = opensrs_request.renew_ssl(attributes)
#puts "---------------------------------------------"
#puts grs.request_xml
#puts grs.response_xml
#
##
#attributes = { reg_type: 'new', product_type: 'malwarescan' }
#grs = opensrs_request.renew_ssl(attributes)
#puts "---------------------------------------------"
#puts grs.request_xml
#puts grs.response_xml
##
#attributes = { reg_type: 'renew', order_id: '123432' }
#grs = opensrs_request.renew_ssl(attributes)
#puts "---------------------------------------------"
#puts grs.request_xml
#puts grs.response_xml
##
#attributes = { reg_type: 'renew', product_id: '123432' }
#grs = opensrs_request.renew_ssl(attributes)
#puts "---------------------------------------------"
#puts grs.request_xml
#puts grs.response_xml
##
#attributes = { reg_type: 'renew', inventory_item_id: '123432' }
#grs = opensrs_request.renew_ssl(attributes)
#puts "---------------------------------------------"
#puts grs.request_xml
#puts grs.response_xml


#puts "---------------------------------------------"
#puts roi.request_xml
#puts roi.response_xml
#puts "---------------------------------------------"
#puts rpi.request_xml
#puts rpi.response_xml
#puts "---------------------------------------------"
#puts rco.request_xml
#puts rco.response_xml
#puts "---------------------------------------------"
#puts rpc.request_xml
#puts rpc.response_xml
#puts "---------------------------------------------"
#puts rsc.request_xml
#puts rsc.response_xml
#
#puts "---------------------------------------------"
#puts ral.request_xml
#puts ral.response_xml
#puts "---------------------------------------------"
#puts rsae.request_xml
#puts rsae.response_xml
#puts "---------------------------------------------"
#puts rrce.request_xml
#puts rrce.response_xml



  ## renew queries
  #def get_renew_ssl_an_order_to_upgrade_a_sitelock_ssl_certificate_to_sitelock_premium
  #  server_local.call(
  #    :action => "SW_REGISTER",
  #    :object => "TRUST_SERVICE",
  #    :attributes => {
  #      :reg_type => 'upgrade'
  #    }
  #  )
  #end
  #
  #def get_renew_ssl_a_new_order_for_a_quickssl_certificate_based_on_an_existing_order
  #  server_local.call(
  #    :action => "SW_REGISTER",
  #    :object => "TRUST_SERVICE",
  #    :attributes => {
  #      :reg_type => 'new',
  #      :product_type => 'quickssl'
  #    }
  #  )
  #end
  #
  #def get_renew_ssl_an_order_for_a_30_day_free_trial_of_a_symantec_securesite_certificate
  #  server_local.call(
  #    :action => "SW_REGISTER",
  #    :object => "TRUST_SERVICE",
  #    :attributes => {
  #      :reg_type => 'new',
  #      :product_type => 'securesite_ft'
  #    }
  #  )
  #end
  #
  #def get_renew_ssl_an_order_for_a_geotrust_web_site_anti_malware_scan_certificate
  #  server_local.call(
  #    :action => "SW_REGISTER",
  #    :object => "TRUST_SERVICE",
  #    :attributes => {
  #      :reg_type => 'new',
  #      :product_type => 'malwarescan'
  #    }
  #  )
  #end
  #
  #def get_renew_ssl_a_renewal_order_for_a_quickssl_certificate_that_was_submitted_by_using_the_order_id(order_id)
  #  server_local.call(
  #    :action => "SW_REGISTER",
  #    :object => "TRUST_SERVICE",
  #    :attributes => {
  #      :reg_type => 'renew',
  #      :order_id => order_id
  #    }
  #  )
  #end
  #
  #def get_renew_ssl_renewal_order_for_a_quickssl_certificate(product_id)
  #  server_local.call(
  #    :action => "SW_REGISTER",
  #    :object => "TRUST_SERVICE",
  #    :attributes => {
  #      :reg_type => 'renew',
  #      :product_id => product_id
  #    }
  #  )
  #end
  #
  #
  #def get_renew_ssl_a_renewal_order_for_a_quickssl_certificate_that_was_submitted_by_using_the_product_id(inventory_item_id)
  #  server_local.call(
  #    :action => "SW_REGISTER",
  #    :object => "TRUST_SERVICE",
  #    :attributes => {
  #      :reg_type => 'renew',
  #      :inventory_item_id => inventory_item_id
  #    }
  #  )
  #end
