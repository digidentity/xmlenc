module Xmlenc
  class EncryptedData
    ALGORITHMS = {
        'http://www.w3.org/2001/04/xmlenc#tripledes-cbc' => Algorithms::DES3CBC,
        'http://www.w3.org/2001/04/xmlenc#aes128-cbc'    => Algorithms::AESCBC[128],
        'http://www.w3.org/2001/04/xmlenc#aes256-cbc'    => Algorithms::AESCBC[256]
    }

    attr_accessor :node

    def initialize(node)
      @node = node
    end

    def document
      @node.document
    end

    def encryption_method
      at_xpath('./xenc:EncryptionMethod')
    end

    def cipher_value
      at_xpath('./xenc:CipherData/xenc:CipherValue').content.gsub(/[\n\s]/, '')
    end

    def decrypt(key)
      decryptor = algorithm.setup(key)
      decryptor.decrypt(Base64.decode64(cipher_value), node: encryption_method)
    end

    private

    def at_xpath(xpath)
      @node.at_xpath(xpath, NAMESPACES)
    end

    def algorithm
      algorithm = encryption_method['Algorithm']
      ALGORITHMS[algorithm] ||
          raise(UnsupportedError.new("Unsupported encryption method #{algorithm}"))
    end
  end
end
