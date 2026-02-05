# frozen_string_literal: true

module Nzbn
  # Base error class for NZBN client
  class Error < StandardError
    attr_reader :response, :code

    def initialize(message = nil, response: nil, code: nil)
      @response = response
      @code = code
      super(message)
    end
  end

  # API error with status code and response body
  class ApiError < Error
    attr_reader :status, :error_code, :error_description, :errors

    def initialize(message = nil, response: nil, status: nil)
      @status = status
      parse_response(response) if response
      super(message || @error_description || 'API Error', response: response, code: @error_code)
    end

    private

    def parse_response(response)
      return unless response.is_a?(Hash)

      @error_code = response['errorCode']
      @error_description = response['errorDescription']
      @errors = response['list'] || []
    end
  end

  # 400 Bad Request - Validation errors
  class ValidationError < ApiError; end

  # 401 Unauthorized - Authentication required
  class AuthenticationError < ApiError; end

  # 403 Forbidden - Authorization denied
  class AuthorizationError < ApiError; end

  # 404 Not Found
  class NotFoundError < ApiError; end

  # 412 Precondition Failed - ETag mismatch
  class PreconditionFailedError < ApiError; end

  # 500 Internal Server Error
  class ServerError < ApiError; end

  # Connection/network errors
  class ConnectionError < Error; end

  # Timeout errors
  class TimeoutError < Error; end

  # Configuration errors
  class ConfigurationError < Error; end
end
