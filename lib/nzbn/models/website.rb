# frozen_string_literal: true

module Nzbn
  module Models
    # Website model
    class Website < Base
      attr_accessor :unique_identifier, :url, :website_purpose, :start_date
    end
  end
end
