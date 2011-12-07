# encoding: UTF-8
require_relative "helper"

Cuba.plugin Cuba::I18N

Cuba.define do
  set_locale req

  on "" do
    res.write i18n.the.main.questions
  end

  on "from/string" do
    res.write i18n & 'the.main.questions'
  end
end

test do
  _, _, body = Cuba.call({ "PATH_INFO" => "/", "SCRIPT_NAME" => "", "rack.input" => StringIO.new })
  assert_response body, ["Why? When? What? How? Who?"]
end

test do
  _, _, body = Cuba.call({ "PATH_INFO" => "/", "SCRIPT_NAME" => "", "rack.input" => StringIO.new, "QUERY_STRING" => "locale=ca" })
  assert_response body, ["Per què? Quan? Què? Com? Qui?"]
end

test do
  _, _, body = Cuba.call({ "PATH_INFO" => "/from/string", "SCRIPT_NAME" => "", "rack.input" => StringIO.new })
  assert_response body, ["Why? When? What? How? Who?"]
end

test do
  _, _, body = Cuba.call({ "PATH_INFO" => "/from/string", "SCRIPT_NAME" => "", "rack.input" => StringIO.new, "HTTP_HOST" => "ca.example.com" })
  assert_response body, ["Per què? Quan? Què? Com? Qui?"]
end

