dir = File.dirname(__FILE__)
$LOAD_PATH.unshift dir unless $LOAD_PATH.include?(dir)

require 'rexml/document'
require 'api_opensrs/opensrs_sslproxy'
require 'api_opensrs/opensrs_request_parse'
require 'api_opensrs/opensrs_command'
require 'api_opensrs/opensrs_client'
load "/home/andrus/Dropbox/dev/opensrs/lib/api_opensrs/opensrs_conf.rb"

module ApiOpenSRS
  VERSION = 0.2.freeze
end