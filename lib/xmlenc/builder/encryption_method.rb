module Xmlenc
  module Builder
    class EncryptionMethod
      include Xmlenc::Builder::Base

      tag "EncryptionMethod"

      register_namespace "xenc", Xmlenc::NAMESPACES[:xenc]
      namespace "xenc"

      attribute :algorithm, String, tag: "Algorithm"

      validates :algorithm, presence: true
    end
  end
end
