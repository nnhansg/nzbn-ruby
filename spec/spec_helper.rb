# frozen_string_literal: true

require 'bundler/setup'
require 'nzbn'
require 'webmock/rspec'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:each) do
    Nzbn.reset_configuration!
  end
end

WebMock.disable_net_connect!(allow_localhost: true)
