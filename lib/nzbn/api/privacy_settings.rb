# frozen_string_literal: true

module Nzbn
  module Api
    # Privacy Settings API
    class PrivacySettings
      def initialize(client)
        @client = client
      end

      # Get privacy settings for an entity
      #
      # @param nzbn [String] 13-digit NZBN
      # @return [Models::PrivacySettings] Privacy settings
      #
      def get(nzbn:)
        response = @client.get("/entities/#{nzbn}/privacy-settings")
        Models::PrivacySettings.new(response)
      end

      # Update privacy settings
      #
      # @param nzbn [String] 13-digit NZBN
      # @param settings [Hash] Privacy settings to update
      # @return [Models::PrivacySettings] Updated settings
      #
      def update(nzbn:, settings:)
        response = @client.put("/entities/#{nzbn}/privacy-settings", settings)
        Models::PrivacySettings.new(response)
      end
    end
  end
end
