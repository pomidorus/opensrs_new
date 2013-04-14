module ApiOpenSRS
  #
  class ApiCommand
    attr :request_hash, :object, :action

    include ApiOpenSRS::Attribute

    AttrH = AttributeHash.new(:request_hash)

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

