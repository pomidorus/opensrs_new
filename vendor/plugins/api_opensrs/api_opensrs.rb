dir = File.dirname(__FILE__)
$LOAD_PATH.unshift dir unless $LOAD_PATH.include?(dir)

require 'rexml/document'
require 'api_opensrs/opensrs_sslproxy'
require 'api_opensrs/opensrs_request_parse'
require 'api_opensrs/opensrs_command'
require 'api_opensrs/opensrs_client'
require 'api_opensrs/opensrs_conf'

module ApiOpenSRS
  def self.gav
    "gav"
  end
end