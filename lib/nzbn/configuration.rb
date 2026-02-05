# frozen_string_literal: true

module Nzbn
  # Configuration class for NZBN client settings
  #
  # @example
  #   Nzbn.configure do |config|
  #     config.api_key = 'your-api-key'
  #     config.base_url = 'https://api.business.govt.nz/gateway/nzbn/v5'
  #     config.timeout = 30
  #   end
  #
  class Configuration
    attr_accessor :api_key, :base_url, :timeout, :open_timeout, :logger

    def initialize
      @api_key = nil
      @base_url = Nzbn::DEFAULT_BASE_URL
      @timeout = 30
      @open_timeout = 10
      @logger = nil
    end

    def valid?
      !api_key.nil? && !api_key.empty?
    end
  end
end
