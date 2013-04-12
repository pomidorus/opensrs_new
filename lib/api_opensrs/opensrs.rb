dir = File.dirname(__FILE__)
$LOAD_PATH.unshift dir unless $LOAD_PATH.include?(dir)

require 'rexml/document'
require 'opensrs/opensrs_sslproxy'
require 'opensrs/opensrs_request_parse'
require 'opensrs/opensrs_command'
require 'opensrs/opensrs_client'


module ApiOpenSRS

  VERSION = 0.2.freeze

end