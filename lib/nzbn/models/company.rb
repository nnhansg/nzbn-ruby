# frozen_string_literal: true

module Nzbn
  module Models
    # Company details model
    class Company < Base
      attr_accessor :annual_return_filing_month, :financial_report_filing_month,
                    :nzsx_code, :annual_return_last_filed, :has_constitution_filed,
                    :country_of_origin, :overseas_company, :extensive_shareholding,
                    :stock_exchange_listed, :shareholding, :ultimate_holding_company,
                    :australian_company_number, :insolvencies, :removal_commenced
    end

    # Non-company entity details (limited partnerships, charities, etc.)
    class NonCompany < Base
      attr_accessor :annual_return_filing_month, :country_of_origin,
                    :registered_union_status, :charities_number, :balance_date
    end
  end
end
