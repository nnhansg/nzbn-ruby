# frozen_string_literal: true

module Nzbn
  module Models
    # Role model (director, partner, trustee, etc.)
    class Role < Base
      attr_accessor :unique_identifier, :role_type, :role_status,
                    :start_date, :end_date, :asic_directorship_yn,
                    :asic_name, :acn, :role_entity, :role_person,
                    :role_address, :role_asic_address

      def initialize(attributes = {})
        super
        @role_person = RolePerson.new(attributes['rolePerson']) if attributes['rolePerson']
      end
    end

    # Person details within a role
    class RolePerson < Base
      attr_accessor :title, :first_name, :middle_names, :last_name

      def full_name
        [first_name, middle_names, last_name].compact.reject(&:empty?).join(' ')
      end
    end
  end
end
