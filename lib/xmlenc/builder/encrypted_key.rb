module Xmlenc
  module Builder
    class EncryptedKey
      include Xmlenc::Builder::ComplexTypes::EncryptedType

      ALGORITHMS = {
          'http://www.w3.org/2001/04/xmlenc#rsa-1_5'        => Algorithms::RSA15,
          'http://www.w3.org/2001/04/xmlenc#rsa-oaep-mgf1p' => Algorithms::RsaOaepMgf1p
      }

      tag "EncryptedKey"
      namespace "xenc"

      has_one :reference_list, Xmlenc::Builder::ReferenceList, xpath: "./"

      attr_accessor :data

      def encrypt(key, data = nil)
        encryptor = algorithm.new(key)
        encrypted = encryptor.encrypt(data || self.data)
        cipher_data.cipher_value = Base64.encode64(encrypted)
      end

      def add_data_reference(data_id)
        self.reference_list ||= ReferenceList.new
        self.reference_list.add_data_reference(data_id)
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
