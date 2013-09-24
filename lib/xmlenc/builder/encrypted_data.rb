module Xmlenc
  module Builder
    class EncryptedData
      include Xmlenc::Builder::ComplexTypes::EncryptedType

      tag "EncryptedData"

      register_namespace "xenc", Xmlenc::NAMESPACES[:xenc]
      namespace "xenc"

      attribute :id, String, tag: "Id"
      attribute :type, String, tag: "Type"
    end
  end
end
