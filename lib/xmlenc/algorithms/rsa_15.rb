module Xmlenc
  module Algorithms
    class Rsa15
      def initialize(key)
        @key = key
      end

      def decrypt(cipher_value, options = {})
        @key.private_decrypt(cipher_value)
      end
    end
  end
end
