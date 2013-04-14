dir = File.dirname(__FILE__)
$LOAD_PATH.unshift dir unless $LOAD_PATH.include?(dir)

require 'rexml/document'

load "/home/andrus/Dropbox/dev/opensrs/lib/api_opensrs/opensrs_sslproxy.rb"
load "/home/andrus/Dropbox/dev/opensrs/lib/api_opensrs/opensrs_request_parse.rb"
load "/home/andrus/Dropbox/dev/opensrs/lib/api_opensrs/opensrs_command.rb"
load "/home/andrus/Dropbox/dev/opensrs/lib/api_opensrs/opensrs_client.rb"
load "/home/andrus/Dropbox/dev/opensrs/lib/api_opensrs/opensrs_conf.rb"

module ApiOpenSRS
  VERSION = 0.2.freeze
end