Gem::Specification.new do |s|
  s.name              = "cuba-contrib"
  s.version           = "0.1.0.rc2"
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
    "test/*.*",
    "views/*.mote"
  ]

  s.add_dependency "cuba"
  s.add_development_dependency "cutest"
  s.add_development_dependency "capybara"
end
