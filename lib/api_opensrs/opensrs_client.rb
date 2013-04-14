module ApiOpenSRS

  #
  class SRSClient < SslProxy
    attr :request, :username, :signature, :api_command

    # authenticate function
    def authenticate?
      # code for authentication
      return false if @username == "sokolov"
      return true if @username == "aseleznov"
    end

    def initialize(request, username, signature)
      @request, @username, @signature = request, username, signature
      @api_command =  ApiCommand.new(request)
    end

    def response
      @api_command.response
    end
  end
end
