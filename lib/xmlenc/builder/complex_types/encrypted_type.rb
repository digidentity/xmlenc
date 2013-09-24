module Xmlenc
  module Builder
    module ComplexTypes
      module EncryptedType
        extend ActiveSupport::Concern
        include Xmlenc::Builder::Base

        included do
          register_namespace "xenc", Xmlenc::NAMESPACES[:xenc]

          has_many :encryption_method, Xmlenc::Builder::EncryptionMethod
          has_many :key_info, Xmlenc::Builder::KeyInfo
          has_many :cipher_data, Xmlenc::Builder::CipherData

          validates :cipher_data, presence: true
        end
      end
    end
  end
end
