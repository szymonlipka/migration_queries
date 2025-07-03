module MigrationQueries
  class FileWriter
    attr_reader :file_path, :sql_queries

    def initialize(file_path, sql_queries: [])
      @file_path = file_path
      @sql_queries = sql_queries
    end

    def write_to_file
      return if sql_queries.empty?

      clear_previous_queries_and_write_new_queries
    rescue StandardError => e
      puts "Error writing to file #{file_path}: #{e.message}"
    end

    private

    def clear_previous_queries_and_write_new_queries
      File.open(file_path, 'r+') do |file|
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
        file.puts "\n# Migration Queries written on #{Time.now}"
        file.puts "=end"
        file.flush
      end
    end
  end
end
