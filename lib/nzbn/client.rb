# frozen_string_literal: true

require 'faraday'
require 'faraday/multipart'
require 'json'
require 'securerandom'

module Nzbn
  # Main HTTP client for NZBN API
  #
  # @example
  #   client = Nzbn::Client.new
  #   client.entities.search(search_term: 'Company Name')
  #
  class Client
    attr_reader :configuration

    def initialize(api_key: nil, base_url: nil, timeout: nil)
      @configuration = Nzbn.configuration&.dup || Configuration.new
      @configuration.api_key = api_key if api_key
      @configuration.base_url = base_url if base_url
      @configuration.timeout = timeout if timeout

      validate_configuration!
    end

    # API Resource Accessors

    def entities
      @entities ||= Api::Entities.new(self)
    end

    def addresses
      @addresses ||= Api::Addresses.new(self)
    end

    def roles
      @roles ||= Api::Roles.new(self)
    end

    def trading_names
      @trading_names ||= Api::TradingNames.new(self)
    end

    def phone_numbers
      @phone_numbers ||= Api::PhoneNumbers.new(self)
    end

    def email_addresses
      @email_addresses ||= Api::EmailAddresses.new(self)
    end

    def websites
      @websites ||= Api::Websites.new(self)
    end

    def industry_classifications
      @industry_classifications ||= Api::IndustryClassifications.new(self)
    end

    def privacy_settings
      @privacy_settings ||= Api::PrivacySettings.new(self)
    end

    def company_details
      @company_details ||= Api::CompanyDetails.new(self)
    end

    def watchlists
      @watchlists ||= Api::Watchlists.new(self)
    end

    def organisation_parts
      @organisation_parts ||= Api::OrganisationParts.new(self)
    end

    def history
      @history ||= Api::History.new(self)
    end

    # HTTP Methods

    def get(path, params = {}, headers = {})
      request(:get, path, params, headers)
    end

    def post(path, body = {}, headers = {})
      request(:post, path, body, headers)
    end

    def put(path, body = {}, headers = {})
      request(:put, path, body, headers)
    end

    def patch(path, body = {}, headers = {})
      request(:patch, path, body, headers)
    end

    def delete(path, params = {}, headers = {})
      request(:delete, path, params, headers)
    end

    private

    def validate_configuration!
      return if configuration.valid?

      raise ConfigurationError, 'API key is required. Configure with Nzbn.configure or pass api_key to Client.new'
    end

    def connection
      @connection ||= Faraday.new(url: configuration.base_url) do |conn|
        conn.request :json
        conn.response :json, content_type: /\bjson$/
        conn.adapter Faraday.default_adapter

        conn.options.timeout = configuration.timeout
        conn.options.open_timeout = configuration.open_timeout

        if configuration.logger
          conn.response :logger, configuration.logger
        end
      end
    end

    def request(method, path, data, headers)
      request_id = SecureRandom.uuid

      merged_headers = default_headers(request_id).merge(headers)

      response = connection.public_send(method) do |req|
        req.url path
        req.headers = merged_headers

        case method
        when :get, :delete
          req.params = data unless data.empty?
        else
          req.body = data
        end
      end

      handle_response(response)
    rescue Faraday::TimeoutError => e
      raise TimeoutError, "Request timed out: #{e.message}"
    rescue Faraday::ConnectionFailed => e
      raise ConnectionError, "Connection failed: #{e.message}"
    end

    def default_headers(request_id)
      {
        'Ocp-Apim-Subscription-Key' => configuration.api_key,
        'api-business-govt-nz-Request-Id' => request_id,
        'Accept' => 'application/json',
        'Content-Type' => 'application/json'
      }
    end

    def handle_response(response)
      case response.status
      when 200..299
        response.body
      when 400
        raise ValidationError.new(response: response.body, status: response.status)
      when 401
        raise AuthenticationError.new('Authentication failed', response: response.body, status: response.status)
      when 403
        raise AuthorizationError.new('Authorization denied', response: response.body, status: response.status)
      when 404
        raise NotFoundError.new('Resource not found', response: response.body, status: response.status)
      when 412
        raise PreconditionFailedError.new('Precondition failed', response: response.body, status: response.status)
      when 500..599
        raise ServerError.new('Server error', response: response.body, status: response.status)
      else
        raise ApiError.new("Unexpected response: #{response.status}", response: response.body, status: response.status)
      end
    end
  end
end
