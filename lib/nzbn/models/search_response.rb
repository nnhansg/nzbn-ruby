# frozen_string_literal: true

module Nzbn
  module Models
    # Paginated search response
    class SearchResponse < Base
      attr_accessor :page_size, :page, :total_items, :sort_by, :sort_order, :items, :links

      def initialize(attributes = {}, item_class: nil)
        super(attributes)
        @items = parse_items(attributes['items'], item_class) if item_class
      end

      def each(&block)
        items.each(&block)
      end

      def map(&block)
        items.map(&block)
      end

      def first
        items.first
      end

      def last
        items.last
      end

      def empty?
        items.nil? || items.empty?
      end

      def count
        items&.length || 0
      end

      alias size count
      alias length count

      private

      def parse_items(data, klass)
        return [] unless data.is_a?(Array)

        data.map { |item| klass.new(item) }
      end
    end
  end
end
