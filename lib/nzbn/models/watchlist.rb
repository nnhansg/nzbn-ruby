# frozen_string_literal: true

module Nzbn
  module Models
    # Watchlist model
    class Watchlist < Base
      attr_accessor :watchlist_id, :name, :user_id, :from_date, :to_date,
                    :organisation_id, :channel, :frequency, :wildcard,
                    :change_event_types, :push_endpoint, :authorization_token,
                    :admin_email_address, :watchlist_email_addresses,
                    :last_successful_change_notice_id, :suspended, :links, :nzbns
    end
  end
end
