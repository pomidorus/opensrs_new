module SlobodaClient
  require 'opensrs'
  require 'libxml'

  class Request
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
end