# frozen_string_literal: true

module Nzbn
  module Models
    # Phone number model
    class PhoneNumber < Base
      attr_accessor :unique_identifier, :phone_purpose, :phone_purpose_description,
                    :phone_country_code, :phone_area_code, :phone_number, :start_date

      def formatted_number
        parts = [phone_country_code, phone_area_code, phone_number].compact.reject(&:empty?)
        parts.join(' ')
      end
    end
  end
end
