# frozen_string_literal: true

require "migration_queries/version"

RSpec.describe MigrationQueries::VERSION do
  it "has a version number" do
    expect(MigrationQueries::VERSION).to eq("0.2.0")
  end
end
