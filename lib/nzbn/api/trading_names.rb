# frozen_string_literal: true

module Nzbn
  module Api
    # Trading Names API
    class TradingNames
      def initialize(client)
        @client = client
      end

      # List trading names for an entity
      #
      # @param nzbn [String] 13-digit NZBN
      # @return [Array<Models::TradingName>] List of trading names
      #
      def list(nzbn:)
        response = @client.get("/entities/#{nzbn}/trading-names")
        return [] unless response.is_a?(Array)

        response.map { |tn| Models::TradingName.new(tn) }
      end

      # Add a trading name
      #
      # @param nzbn [String] 13-digit NZBN
      # @param trading_name [Hash] Trading name attributes
      # @return [Models::TradingName] Created trading name
      #
      def create(nzbn:, trading_name:)
        response = @client.post("/entities/#{nzbn}/trading-names", trading_name)
        Models::TradingName.new(response)
      end
    end
  end
end
