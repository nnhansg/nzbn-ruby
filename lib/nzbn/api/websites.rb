# frozen_string_literal: true

module Nzbn
  module Api
    # Websites API
    class Websites
      def initialize(client)
        @client = client
      end

      # List websites for an entity
      #
      # @param nzbn [String] 13-digit NZBN
      # @return [Array<Models::Website>] List of websites
      #
      def list(nzbn:)
        response = @client.get("/entities/#{nzbn}/websites")
        return [] unless response.is_a?(Array)

        response.map { |ws| Models::Website.new(ws) }
      end

      # Add a website
      #
      # @param nzbn [String] 13-digit NZBN
      # @param website [Hash] Website attributes
      # @return [Models::Website] Created website
      #
      def create(nzbn:, website:)
        response = @client.post("/entities/#{nzbn}/websites", website)
        Models::Website.new(response)
      end
    end
  end
end
