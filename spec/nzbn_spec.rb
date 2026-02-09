# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Nzbn do
  describe 'VERSION' do
    it 'has a version number' do
      expect(Nzbn::VERSION).not_to be_nil
      expect(Nzbn::VERSION).to eq('0.1.3')
    end
  end

  describe 'DEFAULT_BASE_URL' do
    it 'has the correct base URL' do
      expect(Nzbn::DEFAULT_BASE_URL).to eq('https://api.business.govt.nz/gateway/nzbn/v5')
    end
  end

  describe '.configure' do
    it 'allows configuration via block' do
      Nzbn.configure do |config|
        config.api_key = 'test-key'
        config.timeout = 60
      end

      expect(Nzbn.configuration.api_key).to eq('test-key')
      expect(Nzbn.configuration.timeout).to eq(60)
    end
  end

  describe '.reset_configuration!' do
    it 'resets configuration to defaults' do
      Nzbn.configure do |config|
        config.api_key = 'test-key'
      end

      Nzbn.reset_configuration!

      expect(Nzbn.configuration.api_key).to be_nil
    end
  end
end
