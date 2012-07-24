Gem::Specification.new do |s|
  s.name              = "cuba-contrib"
  s.version           = "3.1.0"
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

  s.add_dependency "cuba", "~> 3.1"
  s.add_development_dependency "cutest"
  s.add_development_dependency "mote", "~> 1.0"
end
