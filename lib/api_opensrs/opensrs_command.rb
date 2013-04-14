module ApiOpenSRS
  #
  class ApiCommand
    attr :request_hash, :object, :action

    include ApiOpenSRS::Attribute
    include ApiOpenSRS::ActionDomain

    #For Service Request
    class ActionHashService < Struct

      QUERY_APPROVER_LIST_RESPONSE = "approver_list_response"
      RESEND_APPROVE_EMAIL_RESPONSE = "resend_approve_email"
      RESEND_CERT_EMAIL_RESPONSE = "resend_certificate_email"
      GET_ORDER_INFO_RESPONSE = "order_info_response"
      GET_PRODUCT_INFO_RESPONSE = "product_info_response"
      GET_PRODUCT_INFO_ALL_RESPONSE = "product_info_all_response"
      CANCEL_ORDER_RESPONSE = "cancel_order_response"
      PARSE_CSR_RESPONSE = "parse_csr_response"

      class GPIInfo
       attr :attributes
       def initialize(attributes)
         @attributes = attributes
       end

       def response
         #attributes
         ##client_function(attributes)
         return GET_PRODUCT_INFO_RESPONSE, GET_PRODUCT_INFO_HASH
       end
      end

      class GPIAll
        attr :attributes
       def initialize(attributes)
         @attributes = attributes
       end

       def response
         #attributes
         ##client_function(attributes)
         return GET_PRODUCT_INFO_ALL_RESPONSE, GET_PRODUCT_INFO_ALL_HASH
       end
      end

      class GPIResponse
        attr :attributes
        def self.all_info
          @attributes['all_info']
        end

        def initialize(attributes)
          @attributes = attributes
        end

        def self.create(attributes)
          @attributes = attributes
          case all_info
            when nil
              return GPIInfo.new(attributes)
            when "1"
              return GPIAll.new(attributes)
          end
        end
      end


      def action
        attributes['action'].downcase
      end

      def response
        self.send(action)
      end

      def get_order_info
        #attributes
        ##client_function(attributes)
      end

      def get_product_info
        r = {}
        gpi = GPIResponse.create(attributes)
        r[:layout], r[:data] = gpi.response
        r
      end

      def query_approver_list
        r = {}
        #attributes
        ##client_function(attributes)
        r[:layout], r[:data] = QUERY_APPROVER_LIST_RESPONSE, QUERY_APPROVER_LIST_HASH
        r
      end

      def resend_approve_email
        r = {}
        #attributes
        ##client_function(attributes)
        r[:layout], r[:data] = RESEND_APPROVE_EMAIL_RESPONSE, RESEND_APPROVE_EMAIL_HASH
        r
      end

      def resend_cert_email
        r = {}
        #attributes
        ##client_function(attributes)
        r[:layout], r[:data] = RESEND_CERT_EMAIL_RESPONSE, RESEND_CERT_EMAIL_HASH
        r
      end

      def cancel_order
        r = {}
        #attributes
        ##client_function(attributes)
        r[:layout], r[:data] = CANCEL_ORDER_RESPONSE, CANCEL_ORDER_HASH
        r
      end

      #Parses the CSR and identifies its data elements.
      def parse_csr
        r = {}
        #attributes
        ##client_function(attributes)
        r[:layout], r[:data] = PARSE_CSR_RESPONSE, PARSE_CSR_HASH
        r
      end

      def reg_type
        attributes['reg_type'].downcase
      end

      #Submits a new domain registration or Trust Service request or transfer order that obeys the Reseller's 'process immediately' flag setting
      def sw_register
        r = {}
        swregister = SWRegService.new(attributes)
        r[:layout], r[:data] = swregister.send(reg_type)
        r
      end

    end


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

