module Xmlenc
  module Builder
    class EncryptedData
      include Xmlenc::Builder::ComplexTypes::EncryptedType

      ALGORITHMS = {
          'http://www.w3.org/2001/04/xmlenc#tripledes-cbc' => Algorithms::DES3CBC,
          'http://www.w3.org/2001/04/xmlenc#aes128-cbc'    => Algorithms::AESCBC[128],
          'http://www.w3.org/2001/04/xmlenc#aes256-cbc'    => Algorithms::AESCBC[256]
      }
      TYPES = {
          'http://www.w3.org/2001/04/xmlenc#Element' => :element,
          'http://www.w3.org/2001/04/xmlenc#Content' => :content,
      }

      tag "EncryptedData"
      namespace "xenc"

      attribute :id, String, tag: "Id"
      attribute :type, String, tag: "Type"

      def type
        'http://www.w3.org/2001/04/xmlenc#Element'
      end

      def initialize(attributes = {})
        super
        self.id = SecureRandom.hex(5)
      end

      def encrypt(data)
        encryptor = algorithm.setup
        encrypted = encryptor.encrypt(data, node: encryption_method)
        cipher_data.cipher_value = Base64.encode64(encrypted)

        encrypted_key = EncryptedKey.new(data: encryptor.key)
        encrypted_key.add_data_reference(id)
        encrypted_key
      end

      private

      def algorithm
        algorithm = encryption_method.algorithm
        ALGORITHMS[algorithm] ||
            raise(UnsupportedError.new("Unsupported encryption method #{algorithm}"))
      end
    end
  end
end
