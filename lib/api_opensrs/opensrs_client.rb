module ApiOpenSRS
  class SRSClient < SslProxy
    attr :request, :username, :signature, :response

    # authenticate function
    def authenticate?
      # code for authentication
      false
      true
    end

    def initialize(request, username, signature)
      @request, @username, @signature = request, username, signature
      @response =  ApiCommand.new(request)
    end

    def response
      @response.response
    end
  end
end
