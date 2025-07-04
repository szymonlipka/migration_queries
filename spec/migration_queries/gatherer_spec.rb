# frozen_string_literal: true

require "migration_queries/gatherer"

RSpec.describe MigrationQueries::Gatherer do
  let(:gatherer) { described_class.new }

  describe "#initialize" do
    it "initializes with an empty queries_data_objects array" do
      expect(gatherer.queries_data_objects).to eq([])
    end
  end
end
