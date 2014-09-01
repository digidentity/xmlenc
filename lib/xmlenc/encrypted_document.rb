module Xmlenc
  class EncryptedDocument
    attr_accessor :xml

    def initialize(xml)
      @xml = xml
    end

    def document
      @document ||= Nokogiri::XML(xml, nil, nil, Nokogiri::XML::ParseOptions::STRICT)
    end

    def encrypted_keys
      document.xpath('//xenc:EncryptedKey', NAMESPACES).collect { |n| EncryptedKey.new(n) }
    end

    def decrypt(key)
      encrypted_keys.each do |encrypted_key|
        encrypted_data = encrypted_key.encrypted_data
        data_key       = encrypted_key.decrypt(key)
        encrypted_data.decrypt(data_key)
      end
      @document.to_xml
    end
  end
end
