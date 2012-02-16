require_relative "helper"

test "doesn't override already existing settings" do
  Cuba.settings[:views] = "./templates"
  Cuba.settings[:layout] = "guest"

  Cuba.plugin Cuba::Mote

  assert_equal "./templates", Cuba.settings[:views]
  assert_equal "guest", Cuba.settings[:layout]
end

Cuba.plugin Cuba::Mote
Cuba.use Rack::Session::Cookie
Cuba.settings[:views] = "./test/views"
Cuba.settings[:layout] = "layout"

Cuba.define do
  on "frag" do
    res.write partial("frag", foo: "Bar")
  end

  on "" do
    res.write view("home", title: "Hola")
  end

  on "abs_path" do
    res.write view("./test/views/custom/abs_path.mote", title: "Absolute")
  end
end

test do
  _, _, body = Cuba.call({ "PATH_INFO" => "/", "SCRIPT_NAME" => "" })

  assert_response body, ["<title>Hola</title>\n<h1>Home</h1>\n\n"]
end

test do
  _, _, body = Cuba.call({ "PATH_INFO" => "/frag", "SCRIPT_NAME" => "" })

  assert_response body, ["<h1>Bar</h1>\n"]
end

test do
  _, _, body = Cuba.call({ "PATH_INFO" => "/abs_path", "SCRIPT_NAME" => "" })

  assert_response body, ["<title>Absolute</title>\n<h1>Abs Path</h1>\n\n"]
end
