module ApiOpenSRS
  #
  class ApiCommand
    attr :request_hash, :object, :action

    include ApiOpenSRS::Attribute
    include ApiOpenSRS::ActionDomain
    include ApiOpenSRS::ActionService

    AttrH = AttributeHash.new(:request_hash)
    ActionH = ActionHash.new(:attributes)
    ActionHService = ActionHashService.new(:attributes)

    #-------------------------------------------------------

    class SWRegisterDomain < Struct
      SWREGISTER_NEW_RESPONSE = "sw_register_new_domain_response"

      def new
        #attributes
        ##client_function(attributes)
        return SWREGISTER_NEW_RESPONSE, SWREGISTER_NEW_DOMAIN_HASH
      end
    end

    class SWRegisterService < Struct
      SWREGISTER_NEW_RESPONSE = "sw_register_new_service_response"
      SWREGISTER_RENEW_RESPONSE = "sw_register_renew_service_response"

      def new
        #attributes
        ##client_function(attributes)
        return SWREGISTER_NEW_RESPONSE, SWREGISTER_NEW_SERVICE_HASH
      end

      def renew
        #attributes
        ##client_function(attributes)
        return SWREGISTER_NEW_RESPONSE, SWREGISTER_NEW_SERVICE_HASH
      end

    end


    SWRegDomain = SWRegisterDomain.new(:attributes)
    SWRegService = SWRegisterService.new(:attributes)

    #-------------------------------------------------------

    def initialize(request_hash)
      @request_hash = request_hash
      @object = request_hash[H_OBJECT].downcase
      @action = request_hash[H_ACTION].downcase
    end

    def response
      attribute_hash = AttrH.new(@request_hash)
      attribute_hash.send(@object)
    end

  end
end

