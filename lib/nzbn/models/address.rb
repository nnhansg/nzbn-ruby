# frozen_string_literal: true

module Nzbn
  module Models
    # Address model
    class Address < Base
      attr_accessor :unique_identifier, :start_date, :end_date,
                    :care_of, :address1, :address2, :address3, :address4,
                    :post_code, :country_code, :address_type, :paf_id, :description
    end
  end
end
