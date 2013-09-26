module Xmlenc
  module Builder
    class EncryptedData
      include Xmlenc::Builder::ComplexTypes::EncryptedType

      tag "EncryptedData"
      namespace "xenc"

      attribute :id, String, tag: "Id"
      attribute :type, String, tag: "Type"
    end
  end
end
