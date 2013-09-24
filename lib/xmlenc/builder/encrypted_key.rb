module Xmlenc
  module Builder
    class EncryptedKey
      include Xmlenc::Builder::Base

      tag "EncryptedKey"

      register_namespace "xenc", Xmlenc::NAMESPACES[:xenc]
      namespace "xenc"
    end
  end
end
