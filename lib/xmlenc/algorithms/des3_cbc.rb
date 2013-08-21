module Xmlenc
  module Algorithms
    class DES3CBC
      def self.setup(key)
        new(key)
      end

      def initialize(key)
        @key = key
      end

      def decrypt(cipher_value, options = {})
        cipher.decrypt
        cipher.key = @key
        cipher.iv  = cipher_value[0...iv_len]
        result     = cipher.update(cipher_value[iv_len..-1])
        result << cipher.final
      end

      private

      def iv_len
        cipher.iv_len
      end

      def cipher
        @cipher ||= OpenSSL::Cipher::Cipher.new('des-ede3-cbc')
      end
    end
  end
end
