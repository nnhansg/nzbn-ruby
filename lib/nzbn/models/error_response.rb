# frozen_string_literal: true

module Nzbn
  module Models
    # Error response from API
    class ErrorResponse < Base
      attr_accessor :status, :error_description, :error_code, :list

      def errors
        list || []
      end
    end

    # Individual error field
    class ErrorField < Base
      attr_accessor :field, :message
    end
  end
end
