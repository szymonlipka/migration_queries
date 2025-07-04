# frozen_string_literal: true

require "migration_queries/executer"

RSpec.describe MigrationQueries::Executer do
  let(:adapter) { Class.new }

  describe "#execute" do
    it "captures SQL queries executed during migrations" do
      adapter.define_method(:execute) do |sql|
        sql
      end
      adapter.include(MigrationQueries::Executer)
      allow(caller).to receive(:detect).and_return("db/migrate/20230101010101_create_test.rb:10:in `up'")
      allow(MigrationQueries.gatherer).to receive(:queries_data_objects).and_return([])

      expect { adapter.new.execute("CREATE TABLE test (id INTEGER);") }.not_to raise_error
    end
  end
end
