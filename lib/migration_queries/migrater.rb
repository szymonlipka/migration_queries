require_relative 'file_writer'

module MigrationQueries
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
