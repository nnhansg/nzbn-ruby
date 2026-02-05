# frozen_string_literal: true

module Nzbn
  module Models
    # Trading name model
    class TradingName < Base
      attr_accessor :unique_identifier, :name, :start_date, :end_date
    end
  end
end
