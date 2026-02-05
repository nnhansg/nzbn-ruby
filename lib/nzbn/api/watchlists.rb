# frozen_string_literal: true

module Nzbn
  module Api
    # Watchlists API - Manage change notification watchlists
    class Watchlists
      def initialize(client)
        @client = client
      end

      # List watchlists
      #
      # @param name [String] Filter by name (partial match)
      # @param organisation_id [String] Filter by organisation ID
      # @param page [Integer] Page number
      # @param page_size [Integer] Results per page
      # @param sort_by [String] Sort field
      # @param sort_order [String] ASC or DESC
      # @param change_event_types [String] Filter by change event types
      # @return [Models::SearchResponse] Paginated watchlist results
      #
      def list(name: nil, organisation_id: nil, page: nil, page_size: nil,
               sort_by: nil, sort_order: nil, change_event_types: nil)
        params = {}
        params['name'] = name if name
        params['organisation-id'] = organisation_id if organisation_id
        params['page'] = page if page
        params['page-size'] = page_size if page_size
        params['sort-by'] = sort_by if sort_by
        params['sortorder'] = sort_order if sort_order
        params['change-event-types'] = change_event_types if change_event_types

        response = @client.get('/watchlists', params)
        Models::SearchResponse.new(response, item_class: Models::Watchlist)
      end

      # Get a watchlist by ID
      #
      # @param watchlist_id [String] Watchlist ID
      # @return [Models::Watchlist] Watchlist details
      #
      def get(watchlist_id:)
        response = @client.get("/watchlists/#{watchlist_id}")
        Models::Watchlist.new(response)
      end

      # Create a new watchlist
      #
      # @param watchlist [Hash] Watchlist attributes
      # @return [Models::Watchlist] Created watchlist
      #
      # @example
      #   client.watchlists.create(watchlist: {
      #     name: 'My Watchlist',
      #     channel: 'EMAIL',
      #     frequency: 'DAILY',
      #     changeEventTypes: 'ALL',
      #     adminEmailAddress: 'admin@example.com'
      #   })
      #
      def create(watchlist:)
        response = @client.post('/watchlists', watchlist)
        Models::Watchlist.new(response)
      end

      # Update a watchlist
      #
      # @param watchlist_id [String] Watchlist ID
      # @param watchlist [Hash] Updated watchlist attributes
      # @return [Models::Watchlist] Updated watchlist
      #
      def update(watchlist_id:, watchlist:)
        response = @client.put("/watchlists/#{watchlist_id}", watchlist)
        Models::Watchlist.new(response)
      end

      # Delete a watchlist
      #
      # @param watchlist_id [String] Watchlist ID
      # @return [Boolean] True if successful
      #
      def delete(watchlist_id:)
        @client.delete("/watchlists/#{watchlist_id}")
        true
      end

      # List NZBNs in a watchlist
      #
      # @param watchlist_id [String] Watchlist ID
      # @return [Array<String>] List of NZBNs
      #
      def list_nzbns(watchlist_id:)
        response = @client.get("/watchlists/#{watchlist_id}/nzbns")
        response['nzbns'] || []
      end

      # Add NZBNs to a watchlist
      #
      # @param watchlist_id [String] Watchlist ID
      # @param nzbns [Array<String>] NZBNs to add
      # @return [Boolean] True if successful
      #
      def add_nzbns(watchlist_id:, nzbns:)
        @client.post("/watchlists/#{watchlist_id}/nzbns", { nzbns: nzbns })
        true
      end

      # Remove NZBNs from a watchlist
      #
      # @param watchlist_id [String] Watchlist ID
      # @param nzbns [Array<String>] NZBNs to remove
      # @return [Boolean] True if successful
      #
      def remove_nzbns(watchlist_id:, nzbns:)
        @client.delete("/watchlists/#{watchlist_id}/nzbns", { nzbns: nzbns })
        true
      end
    end
  end
end
