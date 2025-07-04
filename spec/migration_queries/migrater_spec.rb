# frozen_string_literal: true

require "migration_queries/migrater"

RSpec.describe MigrationQueries::Migrater do
  let(:dummy_migration) { Class.new }

  describe "#migrate" do
    it "writes SQL queries to files after migration" do
      dummy_migration.prepend(MigrationQueries::Migrater)
      dummy_migration.define_method(:migrate) { |_direction| }
      allow(MigrationQueries.gatherer)
        .to receive(:queries_data_objects)
        .and_return([
                      double(file_path: "test.sql", sql_queries: ["CREATE TABLE test (id INTEGER);"])
                    ])
      file_writer = instance_double(MigrationQueries::FileWriter)
      allow(MigrationQueries::FileWriter).to receive(:new).and_return(file_writer)
      allow(file_writer).to receive(:write_to_file)

      dummy_migration.new.migrate(:up)

      expect(file_writer).to have_received(:write_to_file)
    end
  end
end
