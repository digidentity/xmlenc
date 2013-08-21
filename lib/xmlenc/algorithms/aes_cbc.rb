module Xmlenc
  module Algorithms
    class AESCBC
      class << self
        def [](size)
          new(size)
        end
      end

      def initialize(size)
        @size = size
      end

      def setup(key)
        @key = key
        self
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
        @cipher ||= OpenSSL::Cipher::Cipher.new("aes-#{@size}-cbc")
      end
    end
  end
end
