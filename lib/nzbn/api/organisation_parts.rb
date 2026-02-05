# frozen_string_literal: true

module Nzbn
  module Api
    # Organisation Parts API (OPN/GLN management)
    class OrganisationParts
      def initialize(client)
        @client = client
      end

      # Search organisation parts
      #
      # @param nzbn [String] Parent NZBN to search within
      # @param opn [String] OPN to search for
      # @param name [String] Name filter
      # @param function [String] Function filter (FUNCTION, PHYSICAL_LOCATION, DIGITAL_LOCATION)
      # @param status [String] Status filter (ACTIVE, INACTIVE)
      # @param page [Integer] Page number
      # @param page_size [Integer] Results per page
      # @return [Models::SearchResponse] Paginated results
      #
      def search(nzbn: nil, opn: nil, name: nil, function: nil, status: nil, page: nil, page_size: nil)
        params = {}
        params['nzbn'] = nzbn if nzbn
        params['opn'] = opn if opn
        params['name'] = name if name
        params['function'] = function if function
        params['status'] = status if status
        params['page'] = page if page
        params['page-size'] = page_size if page_size

        response = @client.get('/entities/organisation-parts', params)
        Models::SearchResponse.new(response, item_class: Models::OrganisationPart)
      end

      # List organisation parts for an entity
      #
      # @param nzbn [String] 13-digit NZBN
      # @return [Array<Models::OrganisationPart>] List of organisation parts
      #
      def list(nzbn:)
        response = @client.get("/entities/#{nzbn}/organisation-parts")
        return [] unless response.is_a?(Array)

        response.map { |op| Models::OrganisationPart.new(op) }
      end

      # Get an organisation part
      #
      # @param nzbn [String] 13-digit NZBN
      # @param opn [String] Organisation part number
      # @return [Models::OrganisationPart] Organisation part details
      #
      def get(nzbn:, opn:)
        response = @client.get("/entities/#{nzbn}/organisation-parts/#{opn}")
        Models::OrganisationPart.new(response)
      end

      # Create an organisation part
      #
      # @param nzbn [String] 13-digit NZBN
      # @param organisation_part [Hash] Organisation part attributes
      # @return [Models::OrganisationPart] Created organisation part
      #
      def create(nzbn:, organisation_part:)
        response = @client.post("/entities/#{nzbn}/organisation-parts", organisation_part)
        Models::OrganisationPart.new(response)
      end

      # Update an organisation part
      #
      # @param nzbn [String] 13-digit NZBN
      # @param opn [String] Organisation part number
      # @param organisation_part [Hash] Updated attributes
      # @return [Models::OrganisationPart] Updated organisation part
      #
      def update(nzbn:, opn:, organisation_part:)
        response = @client.put("/entities/#{nzbn}/organisation-parts/#{opn}", organisation_part)
        Models::OrganisationPart.new(response)
      end

      # Get GLN allocation summary for an entity
      #
      # @param nzbn [String] 13-digit NZBN
      # @return [Hash] Allocation summary
      #
      def gln_allocation(nzbn:)
        @client.get("/entities/#{nzbn}/organisation-parts/allocation")
      end
    end
  end
end
