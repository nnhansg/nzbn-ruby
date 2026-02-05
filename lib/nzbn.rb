# frozen_string_literal: true

require_relative 'nzbn/version'
require_relative 'nzbn/configuration'
require_relative 'nzbn/error'
require_relative 'nzbn/client'

# Models
require_relative 'nzbn/models/base'
require_relative 'nzbn/models/entity'
require_relative 'nzbn/models/full_entity'
require_relative 'nzbn/models/search_entity'
require_relative 'nzbn/models/address'
require_relative 'nzbn/models/role'
require_relative 'nzbn/models/trading_name'
require_relative 'nzbn/models/phone_number'
require_relative 'nzbn/models/email_address'
require_relative 'nzbn/models/website'
require_relative 'nzbn/models/industry_classification'
require_relative 'nzbn/models/privacy_settings'
require_relative 'nzbn/models/company'
require_relative 'nzbn/models/watchlist'
require_relative 'nzbn/models/organisation_part'
require_relative 'nzbn/models/search_response'
require_relative 'nzbn/models/error_response'

# API Resources
require_relative 'nzbn/api/entities'
require_relative 'nzbn/api/addresses'
require_relative 'nzbn/api/roles'
require_relative 'nzbn/api/trading_names'
require_relative 'nzbn/api/phone_numbers'
require_relative 'nzbn/api/email_addresses'
require_relative 'nzbn/api/websites'
require_relative 'nzbn/api/industry_classifications'
require_relative 'nzbn/api/privacy_settings'
require_relative 'nzbn/api/company_details'
require_relative 'nzbn/api/watchlists'
require_relative 'nzbn/api/organisation_parts'
require_relative 'nzbn/api/history'

# NZBN Ruby Client - New Zealand Business Number API
#
# @example Basic usage
#   Nzbn.configure do |config|
#     config.api_key = 'your-api-key'
#   end
#
#   client = Nzbn::Client.new
#   entities = client.entities.search(search_term: 'Company Name')
#
module Nzbn
  DEFAULT_BASE_URL = 'https://api.business.govt.nz/gateway/nzbn/v5'

  class << self
    attr_accessor :configuration

    def configure
      self.configuration ||= Configuration.new
      yield(configuration)
    end

    def reset_configuration!
      self.configuration = Configuration.new
    end
  end
end
