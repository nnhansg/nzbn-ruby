# frozen_string_literal: true

module Nzbn
  module Models
    # Search entity result from entity search
    class SearchEntity < Base
      attr_accessor :entity_status_code, :entity_name, :nzbn, :entity_type_code,
                    :entity_type_description, :entity_status_description,
                    :registration_date, :source_register_unique_id,
                    :trading_names, :classifications, :previous_entity_names, :links

      def initialize(attributes = {})
        super
        parse_nested_objects(attributes)
      end

      private

      def parse_nested_objects(attributes)
        @trading_names = build_model_array(TradingName, attributes['tradingNames'])
        @classifications = build_model_array(IndustryClassification, attributes['classifications'])
        @previous_entity_names = attributes['previousEntityNames'] || []
      end

      def build_model_array(klass, data)
        return [] unless data.is_a?(Array)

        data.map { |item| klass.new(item) }
      end
    end
  end
end
