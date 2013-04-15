dir = File.dirname(__FILE__)
$LOAD_PATH.unshift dir unless $LOAD_PATH.include?(dir)

require 'rexml/document'

require 'api_opensrs/opensrs_conf'
require 'api_opensrs/opensrs_sslproxy'
require 'api_opensrs/opensrs_request_parse'
require 'api_opensrs/actionserv_getproductinfo'
require 'api_opensrs/actionserv_swregister'
require 'api_opensrs/command_action_domain'
require 'api_opensrs/command_action_service'
require 'api_opensrs/command_attribute'
require 'api_opensrs/opensrs_command'
require 'api_opensrs/opensrs_client'

#load "/home/andrus/Dropbox/dev/opensrs/lib/api_opensrs/opensrs_conf.rb"
#load "/home/andrus/Dropbox/dev/opensrs/lib/api_opensrs/opensrs_sslproxy.rb"
#load "/home/andrus/Dropbox/dev/opensrs/lib/api_opensrs/opensrs_request_parse.rb"
#load "/home/andrus/Dropbox/dev/opensrs/lib/api_opensrs/actionserv_getproductinfo.rb"
#load "/home/andrus/Dropbox/dev/opensrs/lib/api_opensrs/actionserv_swregister.rb"
#load "/home/andrus/Dropbox/dev/opensrs/lib/api_opensrs/command_action_domain.rb"
#load "/home/andrus/Dropbox/dev/opensrs/lib/api_opensrs/command_action_service.rb"
#load "/home/andrus/Dropbox/dev/opensrs/lib/api_opensrs/command_attribute.rb"
#load "/home/andrus/Dropbox/dev/opensrs/lib/api_opensrs/opensrs_command.rb"
#load "/home/andrus/Dropbox/dev/opensrs/lib/api_opensrs/opensrs_client.rb"


module ApiOpenSRS
  VERSION = 0.2.freeze
end