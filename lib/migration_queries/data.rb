# frozen_string_literal: true

module MigrationQueries
  # Data class is used to store the file path and SQL queries collected from migrations.
  class Data
    attr_accessor :file_path, :sql_queries

    def initialize(file_path:)
      self.file_path = file_path
      self.sql_queries = []
    end
  end
end
