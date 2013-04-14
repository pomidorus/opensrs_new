module ApiOpenSRS
  module ActionDomain
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

      #def get_product_info
      #  #attributes
      #  ##client_function(attributes)
      #end

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
  end
end

