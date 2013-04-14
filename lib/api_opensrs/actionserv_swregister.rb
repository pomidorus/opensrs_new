module ApiOpenSRS
  module ActionService
    module SWRegister

      #command sw_register for domain and trust_service
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
    end
  end
end