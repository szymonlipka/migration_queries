# frozen_string_literal: true

require "migration_queries/data"

RSpec.describe MigrationQueries::Data do
  let(:data) { described_class.new(file_path: "test.sql") }

  describe "#initialize" do
    it "initializes with a file path and an empty sql_queries array" do
      expect(data.file_path).to eq("test.sql")
      expect(data.sql_queries).to eq([])
    end
  end
end
