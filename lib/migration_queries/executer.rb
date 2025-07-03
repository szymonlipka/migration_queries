# frozen_string_literal: true

require_relative 'data'

module MigrationQueries
  module Executer
    def execute(sql, *_args)
      stack_trace = caller.detect {|path| path.include?(Rails.root.to_s) && path.include?('db/migrate')}
      file_path = stack_trace.match(/(.+):\d+:in/)[1] if stack_trace
      if defined?(file_path) && file_path
        data_object = MigrationQueries.gatherer.queries_data_objects.detect do |data_object|
          data_object.file_path == file_path
        end || MigrationQueries::Data.new(file_path: file_path)
        data_object.sql_queries << sql

        MigrationQueries.gatherer.queries_data_objects << data_object unless MigrationQueries.gatherer.queries_data_objects.include?(data_object)
      end
      super
    end
  end
end

=begin migration_queries
test
=end
