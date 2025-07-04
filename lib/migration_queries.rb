# frozen_string_literal: true

require_relative "migration_queries/version"
require_relative "migration_queries/gatherer"
require_relative "migration_queries/executer"
require_relative "migration_queries/migrater"
require "active_record"

# MigrationQueries is a module that provides functionality to gather, execute, and migrate SQL queries
# during ActiveRecord migrations. It includes the Gatherer, Executer, and Migrater modules to handle
# different aspects of SQL query management.
module MigrationQueries
  class Error < StandardError; end

  def self.gatherer
    @gatherer ||= MigrationQueries::Gatherer.new
  end

  def self.init!
    ActiveRecord::ConnectionAdapters::AbstractAdapter.include(MigrationQueries::Executer)
    ActiveRecord::Migration::Current.include(MigrationQueries::Migrater)
  end
end
