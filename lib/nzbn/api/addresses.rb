# frozen_string_literal: true

module Nzbn
  module Api
    # Addresses API - Manage entity addresses
    class Addresses
      def initialize(client)
        @client = client
      end

      # List addresses for an entity
      #
      # @param nzbn [String] 13-digit NZBN
      # @return [Array<Models::Address>] List of addresses
      #
      def list(nzbn:)
        response = @client.get("/entities/#{nzbn}/addresses")
        parse_addresses(response)
      end

      # Add an address to an entity
      #
      # @param nzbn [String] 13-digit NZBN
      # @param address [Hash] Address attributes
      # @return [Models::Address] Created address
      #
      # @example
      #   client.addresses.create(nzbn: '9429041925676', address: {
      #     addressType: 'POSTAL',
      #     address1: '123 Main St',
      #     address2: 'Wellington',
      #     postCode: '6011',
      #     countryCode: 'NZ'
      #   })
      #
      def create(nzbn:, address:)
        response = @client.post("/entities/#{nzbn}/addresses", address)
        Models::Address.new(response)
      end

      # Delete an address from an entity
      #
      # @param nzbn [String] 13-digit NZBN
      # @param address_id [String] Unique identifier of the address
      # @return [Boolean] True if successful
      #
      def delete(nzbn:, address_id:)
        @client.delete("/entities/#{nzbn}/addresses", { uniqueIdentifier: address_id })
        true
      end

      private

      def parse_addresses(response)
        return [] unless response.is_a?(Hash) && response['addressList']

        response['addressList'].map { |addr| Models::Address.new(addr) }
      end
    end
  end
end
