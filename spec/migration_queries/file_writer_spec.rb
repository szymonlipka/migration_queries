# frozen_string_literal: true

require "migration_queries/file_writer"

RSpec.describe MigrationQueries::FileWriter do
  let(:file_path) { "test.sql" }
  let(:sql_queries) { ["CREATE TABLE test (id INTEGER);"] }
  let(:file_writer) { described_class.new(file_path, sql_queries: sql_queries) }

  describe "#write_to_file" do
    it "writes SQL queries to the file" do
      allow(File).to receive(:open).and_yield(StringIO.new)

      file_writer.write_to_file

      expect(File).to have_received(:open).with(file_path, "r+")
    end
  end
end
