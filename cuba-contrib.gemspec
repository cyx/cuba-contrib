require "./lib/cuba/contrib/version"

Gem::Specification.new do |s|
  s.name              = "cuba-contrib"
  s.version           = Cuba::Contrib::VERSION
  s.summary           = "Cuba plugins and utilities."
  s.description       = "Includes various helper tools for Cuba."
  s.authors           = ["Cyril David"]
  s.email             = ["me@cyrildavid.com"]
  s.homepage          = "http://github.com/cyx/cuba-contrib"

  s.files = Dir[
    "LICENSE",
    "README.markdown",
    "rakefile",
    "lib/**/*.rb",
    "*.gemspec",
    "test/*.*"
  ]

  s.add_dependency "cuba"
  s.add_development_dependency "cutest"
  s.add_development_dependency "capybara"
end