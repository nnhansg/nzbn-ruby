# frozen_string_literal: true

module Nzbn
  module Api
    # Roles API - Manage entity roles (directors, partners, etc.)
    class Roles
      def initialize(client)
        @client = client
      end

      # List roles for an entity
      #
      # @param nzbn [String] 13-digit NZBN
      # @return [Array<Models::Role>] List of roles
      #
      def list(nzbn:)
        response = @client.get("/entities/#{nzbn}/roles")
        return [] unless response.is_a?(Array)

        response.map { |role| Models::Role.new(role) }
      end

      # Add a role to an entity
      #
      # @param nzbn [String] 13-digit NZBN
      # @param role [Hash] Role attributes including roleType, rolePerson, etc.
      # @return [Models::Role] Created role
      #
      # @example
      #   client.roles.create(nzbn: '9429041925676', role: {
      #     roleType: 'PARTNER_INDIVIDUAL',
      #     rolePerson: { firstName: 'John', lastName: 'Doe' },
      #     startDate: '2024-01-01'
      #   })
      #
      def create(nzbn:, role:)
        response = @client.post("/entities/#{nzbn}/roles", role)
        Models::Role.new(response)
      end

      # Update a role
      #
      # @param nzbn [String] 13-digit NZBN
      # @param role [Hash] Updated role attributes
      # @return [Models::Role] Updated role
      #
      def update(nzbn:, role:)
        response = @client.put("/entities/#{nzbn}/roles", role)
        Models::Role.new(response)
      end
    end
  end
end
