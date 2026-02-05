# frozen_string_literal: true

module Nzbn
  module Models
    # Full entity model with all details
    class FullEntity < Base
      attr_accessor :entity_status_code, :entity_name, :nzbn, :entity_type_code,
                    :entity_type_description, :entity_status_description,
                    :registration_date, :source_register, :source_register_unique_identifier,
                    :last_updated_date, :australian_business_number,
                    :hibernation_status_code, :hibernation_status_description,
                    :email_addresses, :addresses, :industry_classifications,
                    :phone_numbers, :websites, :trading_names, :privacy_settings,
                    :company_details, :non_company_details, :roles,
                    :trading_areas, :payment_bank_accounts, :gst_numbers,
                    :supporting_information, :business_ethnicity_identifiers

      def initialize(attributes = {})
        super
        parse_nested_objects(attributes)
      end

      private

      def parse_nested_objects(attributes)
        @addresses = build_addresses(attributes['addresses'])
        @email_addresses = build_model_array(EmailAddress, attributes['emailAddresses'])
        @phone_numbers = build_model_array(PhoneNumber, attributes['phoneNumbers'])
        @websites = build_model_array(Website, attributes['websites'])
        @trading_names = build_model_array(TradingName, attributes['tradingNames'])
        @industry_classifications = build_model_array(IndustryClassification, attributes['industryClassifications'])
        @roles = build_model_array(Role, attributes['roles'])
        @privacy_settings = PrivacySettings.new(attributes['privacySettings']) if attributes['privacySettings']
        @company_details = Company.new(attributes['company-details']) if attributes['company-details']
      end

      def build_addresses(data)
        return [] unless data.is_a?(Hash) && data['addressList']

        data['addressList'].map { |addr| Address.new(addr) }
      end

      def build_model_array(klass, data)
        return [] unless data.is_a?(Array)

        data.map { |item| klass.new(item) }
      end
    end
  end
end
