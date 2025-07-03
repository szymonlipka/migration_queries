# frozen_string_literal: true

require_relative "data"

module MigrationQueries
  # This module extends the ActiveRecord::ConnectionAdapters::AbstractAdapter
  # with logic to capture SQL queries executed during migrations.
  module Executer
    def execute(sql, *_args)
      stack_trace = caller.detect { |path| path.include?(Rails.root.to_s) && path.include?("db/migrate") }
      file_path = stack_trace.match(/(.+):\d+:in/)[1] if stack_trace
      if defined?(file_path) && file_path
        data_object = MigrationQueries.gatherer.queries_data_objects.detect do |data_object|
          data_object.file_path == file_path
        end || MigrationQueries::Data.new(file_path: file_path)
        data_object.sql_queries << sql

        unless MigrationQueries.gatherer.queries_data_objects.include?(data_object)
          MigrationQueries.gatherer.queries_data_objects << data_object
        end
      end
      super
    end
  end
end
