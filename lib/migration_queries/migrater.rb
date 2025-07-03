# frozen_string_literal: true

require_relative "file_writer"

module MigrationQueries
  # Migrater is a module that extends the functionality of ActiveRecord migrations with logic to write SQL queries to files.
  #
  # When included in a migration, it overrides the `migrate` method to write SQL queries to files
  # after executing the migration.
  #
  # Example:
  #   class AddSomeTable < ActiveRecord::Migration[6.0]
  #     include MigrationQueries::Migrater
  #
  #     def change
  #       create_table :some_table do |t|
  #         t.string :name
  #       end
  #     end
  #   end
  #
  #   =begin Migration Queries
  #   CREATE TABLE some_table ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" VARCHAR(255));
  #   =end
  #
  module Migrater
    def migrate(...)
      result = super(...)
      if MigrationQueries.gatherer.queries_data_objects.present?
        MigrationQueries.gatherer.queries_data_objects.each do |data_object|
          MigrationQueries::FileWriter.new(data_object.file_path, sql_queries: data_object.sql_queries).write_to_file
        end
      end
      result
    end
  end
end
