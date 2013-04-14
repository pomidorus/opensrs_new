module ApiOpenSRS
  module Attribute
    #
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

      #
      def attr_value(ch)
        cc = {}
        ch.each do |command|
          cc[command] = request_hash[command]
        end
        cc
      end

      ActionH = ActionHash.new(:attributes)

      #
      def domain
        request_parameters = attr_value(ATTRIBUTE_HASH_DOMAIN[request_hash[H_ACTION]])
        ActionH.new(request_parameters).response
      end

      ActionHService = ActionHashService.new(:attributes)

      #
      def trust_service
        request_parameters = attr_value(ATTRIBUTE_HASH_SERVICE[request_hash[H_ACTION]])
        ActionHService.new(request_parameters).response
      end
    end
  end
end

