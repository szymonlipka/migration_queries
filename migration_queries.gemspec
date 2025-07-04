# frozen_string_literal: true

require_relative "lib/migration_queries/version"

Gem::Specification.new do |spec|
  spec.name = "migration_queries"
  spec.version = MigrationQueries::VERSION
  spec.authors = ["Szymon Lipka"]
  spec.email = ["szymonlipkaa@gmail.com"]

  spec.summary = "Migrations queries for ActiveRecord"
  spec.description = "Gem to generate queries for ActiveRecord migrations, allowing you to see the SQL that will be executed when running migrations."
  spec.homepage = "https://github.com/szymonlipka/migration_queries"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.1.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/szymonlipka/migration_queries"
  spec.metadata["changelog_uri"] = "https://github.com/szymonlipka/migration_queries/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "activerecord", ">= 7.0.0"
end
