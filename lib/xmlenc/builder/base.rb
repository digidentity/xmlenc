require "happymapper"

module Xmlenc
  module Builder
    module Base
      extend ActiveSupport::Concern

      included do
        include ::HappyMapper
        include ::ActiveModel::Validations

        extend HappyMapperClassMethods
        include HappyMapperInstanceMethods
      end

      module HappyMapperInstanceMethods
        def initialize(attributes = {})
          attributes.each do |key, value|
            send("#{key}=", value) if respond_to?("#{key}=") && value.present?
          end
        end

        def from_xml=(bool)
          @from_xml = bool
        end

        def from_xml?
          @from_xml
        end
      end

      module HappyMapperClassMethods
        def parse(xml, options = {})
          object = super
          if object.is_a?(Array)
            object.map { |x| x.from_xml = true }
          elsif object
            object.from_xml = true
          end
          object
        rescue Nokogiri::XML::SyntaxError => e
          raise Xmlenc::UnparseableMessage.new(e.message)
        rescue NoMethodError => e
          raise Xmlenc::UnparseableMessage.new(e.message)
        end
      end
    end
  end
end
