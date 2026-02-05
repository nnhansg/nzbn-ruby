# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Nzbn::Client do
  describe '#initialize' do
    context 'with configuration block' do
      before do
        Nzbn.configure do |config|
          config.api_key = 'test-api-key'
        end
      end

      it 'uses the global configuration' do
        client = described_class.new
        expect(client.configuration.api_key).to eq('test-api-key')
      end
    end

    context 'with inline configuration' do
      it 'overrides global configuration' do
        Nzbn.configure do |config|
          config.api_key = 'global-key'
        end

        client = described_class.new(api_key: 'inline-key')
        expect(client.configuration.api_key).to eq('inline-key')
      end
    end

    context 'without api_key' do
      it 'raises ConfigurationError' do
        expect { described_class.new }.to raise_error(Nzbn::ConfigurationError)
      end
    end
  end

  describe 'API accessors' do
    let(:client) { described_class.new(api_key: 'test-key') }

    it { expect(client.entities).to be_a(Nzbn::Api::Entities) }
    it { expect(client.addresses).to be_a(Nzbn::Api::Addresses) }
    it { expect(client.roles).to be_a(Nzbn::Api::Roles) }
    it { expect(client.trading_names).to be_a(Nzbn::Api::TradingNames) }
    it { expect(client.phone_numbers).to be_a(Nzbn::Api::PhoneNumbers) }
    it { expect(client.email_addresses).to be_a(Nzbn::Api::EmailAddresses) }
    it { expect(client.websites).to be_a(Nzbn::Api::Websites) }
    it { expect(client.industry_classifications).to be_a(Nzbn::Api::IndustryClassifications) }
    it { expect(client.privacy_settings).to be_a(Nzbn::Api::PrivacySettings) }
    it { expect(client.company_details).to be_a(Nzbn::Api::CompanyDetails) }
    it { expect(client.watchlists).to be_a(Nzbn::Api::Watchlists) }
    it { expect(client.organisation_parts).to be_a(Nzbn::Api::OrganisationParts) }
    it { expect(client.history).to be_a(Nzbn::Api::History) }
  end
end
