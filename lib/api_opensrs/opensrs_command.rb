module ApiOpenSRS
  class ApiCommand
    attr :request_hash, :object, :action

    H_ACTION = 'action'
    H_OBJECT = 'object'

    GET_ORDER_INFO = "GET_ORDER_INFO"
    GET_PRODUCT_INFO = "GET_PRODUCT_INFO"
    QUERY_APPROVER_LIST = "QUERY_APPROVER_LIST"
    RESEND_APPROVE_EMAIL = "RESEND_APPROVE_EMAIL"
    RESEND_CERT_EMAIL = "RESEND_CERT_EMAIL"
    SW_REGISTER = "SW_REGISTER"
    CANCEL_ORDER = "CANCEL_ORDER"
    PARSE_CSR = "PARSE_CSR"

    SRS_ACTION = "action"
    SRS_OBJECT = "object"
    SRS_ORDER_ID = "order_id"
    SRS_PRODUCT_ID = "product_id"
    SRS_PRODUCT_TYPE = "product_type"
    SRS_DOMAIN = "domain"
    SRS_CSR = "csr"
    SRS_INVENTORY_ITEM_ID = "inventory_item_id"
    SRS_ALL_INFO = "all_info"

    SRS_REG_TYPE = "reg_type"
    SRS_REGISTRANT_IP = "registrant_ip"
    SRS_CONTACT_SET = "contact_set"
    SRS_CUSTOM_NAMESERVERS = "custom_nameservers"
    SRS_REG_PASSWORD = "reg_password"
    SRS_REG_USERNAME = "reg_username"
    SRS_CUSTOM_TECH_CONTACT = "custom_tech_contact"
    SRS_HANDLE = "handle"

    SRS_APPROVER_EMAIL = "approver_email"
    SRS_SPECIAL_INSTRUCTIONS = "special_instructions"
    SRS_PERIOD = "period"
    SRS_SERVER_TYPE = "server_type"

    class AttributeHash < Struct

      ATTRIBUTE_HASH_DOMAIN = {
        GET_ORDER_INFO => [
          SRS_ACTION, SRS_ORDER_ID
        ],
        GET_PRODUCT_INFO => [
          SRS_ACTION
        ],
        SW_REGISTER => [
          SRS_ACTION, SRS_REGISTRANT_IP, SRS_ORDER_ID, SRS_CONTACT_SET,
          SRS_CUSTOM_NAMESERVERS, SRS_REG_TYPE, SRS_REG_PASSWORD, SRS_REG_USERNAME,
          SRS_DOMAIN, SRS_CUSTOM_TECH_CONTACT
        ]
      }

      ATTRIBUTE_HASH_SERVICE = {
        GET_ORDER_INFO => [
          SRS_ACTION
        ],
        GET_PRODUCT_INFO => [
          SRS_ACTION, SRS_PRODUCT_ID, SRS_ALL_INFO
        ],
        QUERY_APPROVER_LIST => [
          SRS_ACTION, SRS_DOMAIN, SRS_PRODUCT_TYPE
        ],
        RESEND_APPROVE_EMAIL => [
          SRS_ACTION, SRS_ORDER_ID
        ],
        RESEND_CERT_EMAIL => [
          SRS_ACTION, SRS_ORDER_ID
        ],
        CANCEL_ORDER => [
          SRS_ACTION, SRS_ORDER_ID
        ],
        PARSE_CSR => [
          SRS_ACTION, SRS_CSR, SRS_PRODUCT_TYPE
        ],
        SW_REGISTER => [
          SRS_ACTION, SRS_REGISTRANT_IP, SRS_REG_TYPE, SRS_PRODUCT_TYPE,
          SRS_CONTACT_SET, SRS_HANDLE, SRS_APPROVER_EMAIL, SRS_SPECIAL_INSTRUCTIONS,
          SRS_PERIOD, SRS_SERVER_TYPE, SRS_DOMAIN, SRS_PRODUCT_ID
        ]
      }


      def attr_value(ch)
        cc = {}
        ch.each do |command|
          cc[command] = request_hash[command]
        end
        cc
      end

      def domain
        request_parameters = attr_value(ATTRIBUTE_HASH_DOMAIN[request_hash[H_ACTION]])
        ActionH.new(request_parameters).response
      end

      def trust_service
        request_parameters = attr_value(ATTRIBUTE_HASH_SERVICE[request_hash[H_ACTION]])
        ActionHService.new(request_parameters).response
      end
    end

    #For Domain Request
    class ActionHash < Struct

      QUERY_APPROVER_LIST_RESPONSE = "approver_list_response"
      RESEND_APPROVE_EMAIL_RESPONSE = "resend_approve_email"
      RESEND_CERT_EMAIL_RESPONSE = "resend_certificate_email"
      GET_ORDER_INFO_RESPONSE = "order_info_response"
      GET_PRODUCT_INFO_RESPONSE = "product_info_response"

      def action
        attributes['action'].downcase
      end

      def response
        self.send(action)
      end

      def get_order_info
        r = {}
        #attributes
        ##client_function(attributes)
        r[:layout], r[:data] = GET_ORDER_INFO_RESPONSE, GET_ORDER_INFO_HASH
        r
      end

      def get_product_info
        #attributes
        ##client_function(attributes)
      end

      def reg_type
        attributes['reg_type'].downcase
      end

      def sw_register
        r = {}
        swregister = SWRegDomain.new(attributes)
        r[:layout], r[:data] = swregister.send(reg_type)
        r
      end
    end


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

