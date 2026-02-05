# frozen_string_literal: true

module Nzbn
  module Models
    # Email address model
    class EmailAddress < Base
      attr_accessor :unique_identifier, :email_address, :email_purpose,
                    :email_purpose_description, :start_date
    end
  end
end
