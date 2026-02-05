# frozen_string_literal: true

module Nzbn
  module Models
    # Base model class with common functionality
    class Base
      def initialize(attributes = {})
        attributes.each do |key, value|
          setter = "#{underscore(key.to_s)}="
          send(setter, value) if respond_to?(setter)
        end
      end

      def to_h
        instance_variables.each_with_object({}) do |var, hash|
          key = var.to_s.delete('@')
          value = instance_variable_get(var)
          hash[key] = serialize_value(value)
        end
      end

      def to_json(*args)
        to_h.to_json(*args)
      end

      private

      def underscore(str)
        str.gsub(/::/, '/')
           .gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
           .gsub(/([a-z\d])([A-Z])/, '\1_\2')
           .tr('-', '_')
           .downcase
      end

      def camelize(str)
        str.split('_').map.with_index { |word, i| i.zero? ? word : word.capitalize }.join
      end

      def serialize_value(value)
        case value
        when Base
          value.to_h
        when Array
          value.map { |v| serialize_value(v) }
        else
          value
        end
      end

      def build_model(klass, data)
        return nil if data.nil?
        return data.map { |item| build_model(klass, item) } if data.is_a?(Array)

        klass.new(data)
      end
    end
  end
end
