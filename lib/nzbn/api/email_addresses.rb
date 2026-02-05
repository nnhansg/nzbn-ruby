# frozen_string_literal: true

module Nzbn
  module Api
    # Email Addresses API
    class EmailAddresses
      def initialize(client)
        @client = client
      end

      # List email addresses for an entity
      #
      # @param nzbn [String] 13-digit NZBN
      # @return [Array<Models::EmailAddress>] List of email addresses
      #
      def list(nzbn:)
        response = @client.get("/entities/#{nzbn}/email-addresses")
        return [] unless response.is_a?(Array)

        response.map { |email| Models::EmailAddress.new(email) }
      end

      # Add an email address
      #
      # @param nzbn [String] 13-digit NZBN
      # @param email [Hash] Email address attributes
      # @return [Models::EmailAddress] Created email address
      #
      def create(nzbn:, email:)
        response = @client.post("/entities/#{nzbn}/email-addresses", email)
        Models::EmailAddress.new(response)
      end
    end
  end
end
