module Xmlenc
  module Builder
    class ReferenceList
      include Xmlenc::Builder::Base

      tag "ReferenceList"

      register_namespace "xenc", Xmlenc::NAMESPACES[:xenc]
      namespace "xenc"

      has_one :data_reference, Xmlenc::Builder::DataReference, xpath: "./"
    end
  end
end