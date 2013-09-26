module Xmlenc
  module Builder
    module ComplexTypes
      module EncryptedType
        extend ActiveSupport::Concern
        include Xmlenc::Builder::Base

        included do
          register_namespace "xenc", Xmlenc::NAMESPACES[:xenc]

          has_one :encryption_method, Xmlenc::Builder::EncryptionMethod, xpath: "./"
          has_one :key_info, Xmlenc::Builder::KeyInfo, xpath: "./"
          has_one :cipher_data, Xmlenc::Builder::CipherData, xpath: "./"

          validates :cipher_data, presence: true
        end
      end
    end
  end
end
