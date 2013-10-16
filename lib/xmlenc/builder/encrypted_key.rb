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

      def encrypt(key, data)
        encryptor = algorithm.new(key)
        encrypted = encryptor.encrypt(data, node: encryption_method)
        cipher_data.cipher_value = Base64.encode64(encrypted)
      end

      def algorithm
        algorithm = encryption_method.algorithm
        ALGORITHMS[algorithm] ||
            raise(UnsupportedError.new("Unsupported encryption method #{algorithm}"))
      end
    end
  end
end
