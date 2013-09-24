module Xmlenc
  module Builder
    class KeyInfo
      include Xmlenc::Builder::Base

      tag "KeyInfo"

      register_namespace "ds", Xmlenc::NAMESPACES[:ds]
      namespace "ds"

      element :key_name, String, namespace: "ds", tag: "KeyName"

      has_one :encrypted_key, Xmlenc::Builder::EncryptedKey
    end
  end
end
