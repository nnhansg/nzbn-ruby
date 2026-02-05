# frozen_string_literal: true

module Nzbn
  module Api
    # Industry Classifications API
    class IndustryClassifications
      def initialize(client)
        @client = client
      end

      # List industry classifications for an entity
      #
      # @param nzbn [String] 13-digit NZBN
      # @return [Array<Models::IndustryClassification>] List of classifications
      #
      def list(nzbn:)
        response = @client.get("/entities/#{nzbn}/industry-classifications")
        return [] unless response.is_a?(Array)

        response.map { |ic| Models::IndustryClassification.new(ic) }
      end

      # Add an industry classification
      #
      # @param nzbn [String] 13-digit NZBN
      # @param classification [Hash] Classification attributes
      # @return [Models::IndustryClassification] Created classification
      #
      def create(nzbn:, classification:)
        response = @client.post("/entities/#{nzbn}/industry-classifications", classification)
        Models::IndustryClassification.new(response)
      end
    end
  end
end
