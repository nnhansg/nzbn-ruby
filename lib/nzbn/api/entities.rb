# frozen_string_literal: true

module Nzbn
  module Api
    # Entities API - Search and manage NZBN entities
    class Entities
      def initialize(client)
        @client = client
      end

      # Search entities by name
      #
      # @param search_term [String] Text to search for
      # @param entity_status [String] Filter by status (Registered, InLiquidation, etc.)
      # @param entity_type [String] Filter by type (NZCompany, SoleTrader, etc.)
      # @param industry_code [String] Filter by industry code
      # @param page [Integer] Page number (zero-indexed)
      # @param page_size [Integer] Results per page
      # @return [Models::SearchResponse] Paginated search results
      #
      # @example
      #   client.entities.search(search_term: 'Company Name', entity_status: 'Registered')
      #
      def search(search_term:, entity_status: nil, entity_type: nil, industry_code: nil, page: nil, page_size: nil)
        params = { 'search-term' => search_term }
        params['entity-status'] = entity_status if entity_status
        params['entity-type'] = entity_type if entity_type
        params['industry-code'] = industry_code if industry_code
        params['page'] = page if page
        params['page-size'] = page_size if page_size

        response = @client.get('/entities', params)
        Models::SearchResponse.new(response, item_class: Models::SearchEntity)
      end

      # Get entity by NZBN
      #
      # @param nzbn [String] 13-digit NZBN
      # @param if_none_match [String] ETag for conditional request
      # @return [Models::FullEntity] Full entity details
      #
      # @example
      #   entity = client.entities.get(nzbn: '9429041925676')
      #
      def get(nzbn:, if_none_match: nil)
        headers = {}
        headers['If-None-Match'] = if_none_match if if_none_match

        response = @client.get("/entities/#{nzbn}", {}, headers)
        Models::FullEntity.new(response)
      end

      # Get discoverable entity information
      #
      # @param nzbn [String] 13-digit NZBN
      # @return [Models::Entity] Discoverable entity info
      #
      def get_discoverable(nzbn:)
        response = @client.get("/entities/#{nzbn}/discoverable")
        Models::Entity.new(response)
      end

      # Search entity changes
      #
      # @param change_event_type [String] Comma-separated change events (NEW, ENTITY, ROLES_DIRECTOR, etc.)
      # @param entity_type [String] Filter by entity type
      # @param date_time_from [String] Start date (YYYY-MM-DDThh:mm:ss)
      # @param date_time_to [String] End date (YYYY-MM-DDThh:mm:ss)
      # @param page [Integer] Page number
      # @param page_size [Integer] Results per page
      # @param sort_by [String] Sort field (NZBN, ENTITY_NAME, etc.)
      # @param sort_order [String] ASC or DESC
      # @return [Models::SearchResponse] Change results
      #
      def changes(change_event_type:, entity_type: nil, date_time_from: nil, date_time_to: nil,
                  page: nil, page_size: nil, sort_by: nil, sort_order: nil)
        params = { 'change-event-type' => change_event_type }
        params['entity-type'] = entity_type if entity_type
        params['date-time-from'] = date_time_from if date_time_from
        params['date-time-to'] = date_time_to if date_time_to
        params['page'] = page if page
        params['page-size'] = page_size if page_size
        params['sort-by'] = sort_by if sort_by
        params['sort-order'] = sort_order if sort_order

        response = @client.get('/entities/changes', params)
        Models::SearchResponse.new(response, item_class: Models::SearchEntity)
      end

      # Create a new entity (sole trader, partnership, or trust)
      #
      # @param entity [Hash] Entity attributes
      # @return [Hash] Created entity response
      #
      def create(entity:)
        @client.post('/entities', entity)
      end

      # Update entity status
      #
      # @param nzbn [String] 13-digit NZBN
      # @param status [Hash] Status update payload
      # @return [Hash] Updated status
      #
      def update_status(nzbn:, status:)
        @client.post("/entities/#{nzbn}/entity-statuses", status)
      end

      # Update Australian Business Number
      #
      # @param nzbn [String] 13-digit NZBN
      # @param abn_data [Hash] ABN update payload
      # @return [Hash] Updated ABN
      #
      def update_abn(nzbn:, abn_data:)
        @client.put("/entities/#{nzbn}/australian-business-number", abn_data)
      end
    end
  end
end
