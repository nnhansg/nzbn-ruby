# frozen_string_literal: true

module Nzbn
  module Models
    # Entity model representing a basic NZBN entity
    class Entity < Base
      attr_accessor :entity_status_code, :entity_name, :nzbn, :entity_type_code,
                    :entity_type_description, :entity_status_description,
                    :registration_date, :source_register, :source_register_unique_identifier,
                    :last_updated_date, :australian_business_number,
                    :hibernation_status_code, :hibernation_status_description
    end
  end
end
