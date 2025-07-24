# frozen_string_literal: true

module MigrationQueries
  # FileWriter is responsible for writing SQL queries to a specified file.
  class FileWriter
    attr_reader :file_path, :sql_queries

    def initialize(file_path, sql_queries: [])
      @file_path = file_path
      @sql_queries = sql_queries
    end

    def write_to_file
      return if sql_queries.empty?

      File.open(file_path, "r+") do |file|
        content = file.readlines
        filtered_content = []
        inside_block = false

        content.each do |line|
          if line.strip == "=begin Migration Queries"
            inside_block = true
            next
          elsif line.strip == "=end"
            inside_block = false
            next
          end
          filtered_content << line unless inside_block
        end

        file.rewind
        file.truncate(0)
        filtered_content.each { |line| file.puts line }
        file.puts "=begin Migration Queries"
        sql_queries.each do |query|
          file.puts query
        end
        file.puts "=end"
        file.flush
      end
    rescue StandardError => e
      puts "Error writing to file #{file_path}: #{e.message}"
    end
  end
end
