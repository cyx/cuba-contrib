require "./lib/cuba/contrib/version"

Gem::Specification.new do |s|
  s.name              = "cuba-contrib"
  s.version           = Cuba::Contrib::VERSION
  s.summary           = "Cuba plugins and utilities."
  s.description       = "Includes various helper tools for Cuba."
  s.authors           = ["Cyril David", "Dario Castañé"]
  s.email             = ["me@cyrildavid.com", "i@dario.im"]
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
  s.add_dependency "mote"
  s.add_dependency "bluecloth"
  s.add_dependency "r18n-core"
  s.add_development_dependency "cutest"
  s.add_development_dependency "capybara"
end
