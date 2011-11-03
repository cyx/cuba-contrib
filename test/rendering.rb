require_relative "helper"

Cuba.plugin Cuba::Rendering
Cuba.views = "./test/views"

Cuba.define do
  on "home" do
    res.write view("home", name: "Agent Smith", title: "Home")
  end

  on "about" do
    res.write partial("about", title: "About Cuba")
  end
end

test "partial" do
  _, _, body = Cuba.call({ "PATH_INFO" => "/about", "SCRIPT_NAME" => "/" })

  assert_response body, ["<h1>About Cuba</h1>"]
end

test "view" do
  _, _, body = Cuba.call({ "PATH_INFO" => "/home", "SCRIPT_NAME" => "/" })

  assert_response body, ["<title>Cuba: Home</title>\n<h1>Home</h1>\n<p>Hello Agent Smith</p>"]
end

test "partial with str as engine" do
  Cuba.template_engine = "str"

  _, _, body = Cuba.call({ "PATH_INFO" => "/about", "SCRIPT_NAME" => "/" })

  assert_response body, ["<h1>About Cuba</h1>"]
end

test "view with str as engine" do
  Cuba.template_engine = "str"

  _, _, body = Cuba.call({ "PATH_INFO" => "/home", "SCRIPT_NAME" => "/" })

  assert_response body, ["<title>Cuba: Home</title>\n<h1>Home</h1>\n<p>Hello Agent Smith</p>"]
end