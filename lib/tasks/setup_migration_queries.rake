# lib/tasks/setup_migration_queries.rake

namespace :migration_queries do
  desc "Create migration_queries.rb initializer"
  task :setup do
    initializer_path = Rails.root.join("config", "initializers", "migration_queries.rb")
    content = <<~RUBY
      # frozen_string_literal: true

      if Rails.env.development?
        require 'migration_queries'

        MigrationQueries.init!
      end
    RUBY

    if File.exist?(initializer_path)
      puts "Initializer file already exists at #{initializer_path}"
    else
      File.write(initializer_path, content)
      puts "Created initializer file at #{initializer_path}"
    end
  end
end
