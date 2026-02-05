# frozen_string_literal: true

module Nzbn
  module Api
    # Company Details API
    class CompanyDetails
      def initialize(client)
        @client = client
      end

      # Get company details
      #
      # @param nzbn [String] 13-digit NZBN
      # @return [Models::Company] Company details
      #
      def get(nzbn:)
        response = @client.get("/entities/#{nzbn}/company-details")
        Models::Company.new(response)
      end

      # Get non-company details (limited partnerships, charities, etc.)
      #
      # @param nzbn [String] 13-digit NZBN
      # @return [Models::NonCompany] Non-company details
      #
      def get_non_company(nzbn:)
        response = @client.get("/entities/#{nzbn}/non-company-details")
        Models::NonCompany.new(response)
      end
    end
  end
end
