module ApiOpenSRS

  #Класс для обработки входящих реквестов и отдачи необходимого респонса
  class SRSClient < SslProxy
    attr :request, :username, :signature, :api_command

    # метод авторизации на клиенте
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
