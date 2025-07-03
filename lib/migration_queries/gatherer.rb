module MigrationQueries
  # Gatherer is responsible for collecting SQL queries from migrations.
  class Gatherer
    attr_accessor :queries_data_objects

    def initialize
      self.queries_data_objects = []
    end
  end
end
