# frozen_string_literal: true

module Nzbn
  module Models
    # Privacy settings model
    class PrivacySettings < Base
      attr_accessor :nzbn_private_information, :entity_type_private_information,
                    :start_date_private_information, :status_private_information,
                    :location_id_private_information, :name_private_information,
                    :trading_name_private_information, :web_site_private_information,
                    :business_classification_private_information, :gst_status_private_information,
                    :phone_private_information, :email_private_information,
                    :registered_address_private_information, :postal_address_private_information,
                    :principal_address_private_information, :other_address_private_information,
                    :partners_private_information, :trustees_private_information,
                    :public_suggest_changes_yn, :gst_effective_date_private_information,
                    :physical_address_private_information, :australian_business_number_private_information,
                    :australian_company_number_private_information, :australian_service_address_private_information,
                    :abn_private_information, :gst_number_private_information,
                    :payment_bank_account_numbers_private_information,
                    :service_address_private_information, :invoice_address_private_information,
                    :delivery_address_private_information, :office_address_private_information,
                    :business_ethnicity_private_information
    end
  end
end
