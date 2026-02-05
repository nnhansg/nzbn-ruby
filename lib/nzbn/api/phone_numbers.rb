# frozen_string_literal: true

module Nzbn
  module Api
    # Phone Numbers API
    class PhoneNumbers
      def initialize(client)
        @client = client
      end

      # List phone numbers for an entity
      #
      # @param nzbn [String] 13-digit NZBN
      # @return [Array<Models::PhoneNumber>] List of phone numbers
      #
      def list(nzbn:)
        response = @client.get("/entities/#{nzbn}/phone-numbers")
        return [] unless response.is_a?(Array)

        response.map { |pn| Models::PhoneNumber.new(pn) }
      end

      # Add a phone number
      #
      # @param nzbn [String] 13-digit NZBN
      # @param phone [Hash] Phone number attributes
      # @return [Models::PhoneNumber] Created phone number
      #
      def create(nzbn:, phone:)
        response = @client.post("/entities/#{nzbn}/phone-numbers", phone)
        Models::PhoneNumber.new(response)
      end
    end
  end
end
