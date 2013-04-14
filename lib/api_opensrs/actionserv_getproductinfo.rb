module ApiOpenSRS
  module ActionService
    module GetProductInfo
      #response for get_product_info command
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

      #response for get_product_info command with attribute all_info
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

      #factory for create class response based on all_info attribute
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
    end
  end
end
