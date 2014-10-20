$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "seasonable/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "seasonable"
  s.version     = Seasonable::VERSION
  s.authors     = ["Antonio J Rossi", "Alejandro León"]
  s.email       = ["antonio.rossi@the-cocktail.com", "alejandro.leon@the-cocktail.com"]
  s.homepage    = ""
  s.summary     = "Add publication dates to models."
  s.description = "Add publication dates to models."
  s.license     = ""

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.1.6"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "minitest-rails-capybara", "~> 2.1.1"
  s.add_development_dependency "minitest-reporters", "~> 1.0.5"
  s.add_development_dependency "database_cleaner", "~> 1.3.0"
  s.add_development_dependency "factory_girl_rails", "~> 4.0"
  
end
