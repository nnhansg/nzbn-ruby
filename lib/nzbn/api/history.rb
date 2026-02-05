# frozen_string_literal: true

module Nzbn
  module Api
    # History API - Access historical entity data
    class History
      def initialize(client)
        @client = client
      end

      # Get entity change history
      #
      # @param nzbn [String] 13-digit NZBN
      # @return [Hash] Change history
      #
      def get(nzbn:)
        @client.get("/entities/#{nzbn}/history")
      end

      # Get address history
      #
      # @param nzbn [String] 13-digit NZBN
      # @return [Array<Models::Address>] Historical addresses
      #
      def addresses(nzbn:)
        response = @client.get("/entities/#{nzbn}/history/addresses")
        return [] unless response.is_a?(Array)

        response.map { |addr| Models::Address.new(addr) }
      end

      # Get entity name history
      #
      # @param nzbn [String] 13-digit NZBN
      # @return [Array<Hash>] Historical entity names
      #
      def entity_names(nzbn:)
        @client.get("/entities/#{nzbn}/history/entity-names")
      end

      # Get trading name history
      #
      # @param nzbn [String] 13-digit NZBN
      # @return [Array<Models::TradingName>] Historical trading names
      #
      def trading_names(nzbn:)
        response = @client.get("/entities/#{nzbn}/history/trading-names")
        return [] unless response.is_a?(Array)

        response.map { |tn| Models::TradingName.new(tn) }
      end

      # Get trading area history
      #
      # @param nzbn [String] 13-digit NZBN
      # @return [Array<Hash>] Historical trading areas
      #
      def trading_areas(nzbn:)
        @client.get("/entities/#{nzbn}/history/trading-areas")
      end

      # Get entity status history
      #
      # @param nzbn [String] 13-digit NZBN
      # @return [Array<Hash>] Historical entity statuses
      #
      def entity_statuses(nzbn:)
        @client.get("/entities/#{nzbn}/history/entity-statuses")
      end

      # Get hibernation status history
      #
      # @param nzbn [String] 13-digit NZBN
      # @return [Array<Hash>] Historical hibernation statuses
      #
      def hibernation_statuses(nzbn:)
        @client.get("/entities/#{nzbn}/history/hibernation-statuses")
      end
    end
  end
end
