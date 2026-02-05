# frozen_string_literal: true

module Nzbn
  module Models
    # Organisation part (OPN/GLN) model
    class OrganisationPart < Base
      attr_accessor :opn, :parent_nzbn, :parent_nzbn_name, :parent_gln, :name,
                    :purposes, :function, :organisation_part_status,
                    :addresses, :phone_numbers, :email_addresses,
                    :gst_number, :payment_bank_account_number, :custom_data,
                    :privacy, :nzbn_list, :start_date, :status_date
    end
  end
end
