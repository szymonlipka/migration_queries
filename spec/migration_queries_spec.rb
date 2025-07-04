# frozen_string_literal: true

require "migration_queries"
require "active_record"

RSpec.describe MigrationQueries do
  describe ".gatherer" do
    it "returns an instance of MigrationQueries::Gatherer" do
      expect(MigrationQueries.gatherer).to be_a(MigrationQueries::Gatherer)
    end
  end
end
