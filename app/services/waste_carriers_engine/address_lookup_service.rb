# frozen_string_literal: true

require "rest-client"
require "benchmark"

module WasteCarriersEngine
  class AddressLookupService < BaseService
    def run(postcode)
      result = nil
      execution_time = Benchmark.realtime do
        result = DefraRuby::Address::EaAddressFacadeV11Service.run(postcode)
      end

      # Log the execution time
      Rails.logger.info("AddressLookupService execution time: #{execution_time.round(4)} seconds")

      result
    end
  end
end
