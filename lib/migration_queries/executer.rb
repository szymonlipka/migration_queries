# frozen_string_literal: true

require_relative "data"

module MigrationQueries
  # This module extends the ActiveRecord::ConnectionAdapters::AbstractAdapter
  # with logic to capture SQL queries executed during migrations.
  module Executer
    def execute(sql, *_args)
      gather_queries(sql, caller)
      super
    end

    private

    def gather_queries(sql, caller)
      stack_trace = detect_stack_trace(caller)
      file_path = extract_file_path(stack_trace) if stack_trace
      gatherer = load_gatherer
      return unless defined?(file_path) && file_path

      data_object = gatherer.queries_data_objects.detect do |data_object|
        data_object.file_path == file_path
      end || MigrationQueries::Data.new(file_path: file_path)
      data_object.sql_queries << sql

      return if gatherer.queries_data_objects.include?(data_object)

      MigrationQueries.gatherer.queries_data_objects << data_object
    end

    def load_gatherer
      MigrationQueries.gatherer
    end

    def detect_stack_trace(caller)
      caller.detect { |path| path.include?(Rails.root.to_s) && path.include?("db/migrate") }
    end

    def extract_file_path(stack_trace)
      stack_trace.match(/(.+):\d+:in/)[1]
    end
  end
end
