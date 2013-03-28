#encoding: utf-8
require "spec_helper"
require 'opensrs'

#describe "/opensrs" do
#
#  describe "Parse CSR request" do
#
#    context "request is correct" do
#      #let(:user) {Factory(:user)}
#      let(:server_local) {OpenSRS::Server.new(:server   => "http://localhost:5000/opensrs",
#                                              :username => "aseleznov",
#                                              :password => "53cr3t",
#                                              :key      => "c633be3170c7fb3fb29e2f99b84be2410" )}
#
#      let(:server_remote) {OpenSRS::Server.new(:server   => "http://localhost:3000/opensrs",
#                                              :username => "aseleznov",
#                                              :password => "53cr3t",
#                                              :key      => "c633be3170c7fb3fb29e2f99b84be2410" )}
#
#      before(:each) do
#        OpenSRS::Server.xml_processor = :nokogiri
#      end
#
#      before(:all) do
#        @csr = '-----BEGIN CERTIFICATE REQUEST----- MIIBqTCCARICAQAwaTELMAkGA1UEBhMCQ0ExCzAJBgNVBAgTAm9uMRAwDgYDVQ QH Ewd0b3JvbnRvMQ8wDQYDVQQKEwZ0dWNvd3MxCzAJBgNVBAsTAnFhMR0wGwYDVQ QD ExR3d3cucWFyZWdyZXNzaW9uLm9yZzCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkC gYEAz+hbqqnE5BSW0THf7txxsJxF8Vtca2uL52iutI1SRTm9J6NNtAjgMbL9upOm SFnObpWKriUIlvxKrecygGWkjiMeyU/F6auAS9/vwDdxYEVT2szK+Q2At1FgU433 Pds53v2J/vyB6SL+k/w54H2gF4ORpU1hjUggo7fM353TeeMCAwEAAaAAMA0GCSqG SIb3DQEBBAUAA4GBAIYvVThVeocN7N7HbsO/au9AXnx6LULQ5LMDWx6FlyBB5g9h 5HYZa6xieYCYDxYIsjLjR3qx1BWl9+0kSL2MW4EdDPzbcrZvHAtrw2/hPrm9EGA3 2w3a26W79N3clCkrahnpcNFLFyzU3CtZASJ+VuixGXTEkdiBAliqtGp+QBhf -----END CERTIFICATE REQUEST-----'
#        # User.create!({name: "aseleznov", signature: "2e5e7688aba0879ad1d6b48c724af427"})
#      end
#
#      def get_parse_csr(product_type,csr)
#        server_local.call(
#          :action => "PARSE_CSR",
#          :object => "TRUST_SERVICE",
#          :attributes => {
#            :product_type => product_type,
#            :csr => csr
#          }
#        )
#      end
#
#      it "request body is correct" do
#        xml_request_parse_csr = File.read(File.join(Rails.root, 'spec','api','v2','patterns','parse_csr','request_parse_csr.xml'))
#        get_parse_csr("quickssl", @csr).request_xml.should == xml_request_parse_csr
#      end
#
#
#      it "username is correct"
#      it "signature is correct"
#      it "authorization is correct"
#
#
#      it "action is PARSE_CSR" do
#        opensrs_request = OpenSRSRequestParse.new(get_parse_csr("quickssl", @csr).request_xml).request_hash
#        opensrs_request["action"].should == "PARSE_CSR"
#      end
#
#      it "object is TRUST_SERVICE" do
#        opensrs_request = OpenSRSRequestParse.new(get_parse_csr("quickssl", @csr).request_xml).request_hash
#        opensrs_request["object"].should == "TRUST_SERVICE"
#      end
#
#      it "product_type is quickssl" do
#        opensrs_request = OpenSRSRequestParse.new(get_parse_csr("quickssl", @csr).request_xml).request_hash
#        opensrs_request["product_type"].should == "quickssl"
#      end
#
#    end
#
#  end
#
#
#  describe "Parse CSR response" do
#
#    context "response is correct" do
#
#      it "response is OK"
#      it "body is correct"
#      it "owner is correct"
#
#    end
#
#  end
#
#
#end
