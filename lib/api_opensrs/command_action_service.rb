module ApiOpenSRS
  module ActionService
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

      include ApiOpenSRS::ActionService::GetProductInfo

      include ApiOpenSRS::ActionService::SWRegister
      SWRegService = SWRegisterService.new(:attributes)

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
        gpi_response = GPIResponse.create(attributes)
        r[:layout], r[:data] = gpi_response.response
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
  end
end
