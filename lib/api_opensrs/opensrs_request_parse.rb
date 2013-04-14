module ApiOpenSRS

  #
  #
  #
  class OpenSRSRequestParse
    attr :xml

    def initialize(xml)
      @xml = xml
    end

    def request_hash_rexml
      doc = REXML::Document.new xml
      h = {}
      doc.elements.each("//dt_assoc/item") { |element| h[element.attributes['key']] = element.text}
      contact_set = {}
      doc.elements.each('//dt_assoc/item[@key = "contact_set"]/dt_assoc/item') do |element|
        contact = {}
        element.elements.each("./dt_assoc/item") {|e| contact[e.attributes['key']] = e.text}
        contact_set[element.attributes['key']] = contact
      end
      h["contact_set"] = contact_set
      h
    end
  end
end

