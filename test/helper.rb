$:.unshift(File.expand_path("../lib", File.dirname(__FILE__)))

require "cuba"
require "cuba/contrib"

def assert_response(body, expected)
  arr = []
  body.each { |line| arr << line }

  assert_equal arr, expected
end