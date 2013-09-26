module Xmlenc
  module Builder
    class EncryptedKey
      include Xmlenc::Builder::ComplexTypes::EncryptedType

      tag "EncryptedKey"
      namespace "xenc"
    end
  end
end
