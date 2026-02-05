# frozen_string_literal: true

module Nzbn
  module Models
    # Industry classification (ANZSIC) model
    class IndustryClassification < Base
      attr_accessor :unique_identifier, :classification_code, :classification_description
    end
  end
end
