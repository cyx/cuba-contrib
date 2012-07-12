# encoding: utf-8

require_relative "helper"

setup do
  obj = Object.new
  obj.extend Cuba::TextHelpers
end

test "truncate" do |helper|
  assert_equal "the q...", helper.truncate("the quick brown", 5)

  assert_equal "same string", helper.truncate("same string", 11)
end

test "markdown" do |helper|
  require "bluecloth"
  assert_equal "<h1>Hola Mundo</h1>", helper.markdown("# Hola Mundo")
end

test "nl2br" do |helper|
  assert_equal "Hi<br>there<br>Joe", helper.nl2br("Hi\nthere\r\nJoe")
end

test "currency" do |helper|
  assert_equal "$ 2.22", helper.currency(2.221)
  assert_equal "€ 2.22", helper.currency(2.221, "€")
end

test "delimit" do |helper|
  assert_equal "2,000", helper.delimit(2000)
  assert_equal "2.000", helper.delimit(2000, ".")
  assert_equal "2,000,000", helper.delimit(2000000)
  assert_equal "2,000,000.05", helper.delimit(2000000.05)
end

test "titlecase" do |helper|
  assert_equal "Hello World", helper.titlecase("hello world")
end

test "underscore" do |helper|
  assert_equal "foo_bar_baz", helper.underscore("FooBarBaz")
  assert_equal "ohm_v1_foo", helper.underscore("OhmV1Foo")
  assert_equal "ssl_error", helper.underscore("SSLError")
  assert_equal "net_http", helper.underscore("NetHTTP")
end
