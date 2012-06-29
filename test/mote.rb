require_relative "helper"

test "doesn't override already existing settings" do
  Cuba.settings[:mote] ||= {}
  Cuba.settings[:mote][:views] = "./templates"
  Cuba.settings[:mote][:layout] = "guest"

  Cuba.plugin Cuba::Mote

  assert_equal "./templates", Cuba.settings[:mote][:views]
  assert_equal "guest", Cuba.settings[:mote][:layout]
end

Cuba.plugin Cuba::Mote
Cuba.use Rack::Session::Cookie
Cuba.settings[:mote][:views] = "./test/views"
Cuba.settings[:mote][:layout] = "layout"

Cuba.define do
  on "frag" do
    res.write partial("frag", foo: "Bar")
  end

  on "" do
    res.write view("home", title: "Hola")
  end

  on "render" do
    render("home", title: "Hola")
  end

  on "abs_path" do
    res.write view("./test/views/custom/abs_path.mote", title: "Absolute")
  end
end

test "view" do
  _, _, body = Cuba.call({ "PATH_INFO" => "/", "SCRIPT_NAME" => "" })

  assert_response body, ["<title>Hola</title>\n<h1>Home</h1>\n\n"]
end

test "render" do
  _, _, body = Cuba.call({ "PATH_INFO" => "/render", "SCRIPT_NAME" => "" })

  assert_response body, ["<title>Hola</title>\n<h1>Home</h1>\n\n"]
end


test "partial" do
  _, _, body = Cuba.call({ "PATH_INFO" => "/frag", "SCRIPT_NAME" => "" })

  assert_response body, ["<h1>Bar</h1>\n"]
end

test "use of absolute mote path" do
  _, _, body = Cuba.call({ "PATH_INFO" => "/abs_path", "SCRIPT_NAME" => "" })

  assert_response body, ["<title>Absolute</title>\n<h1>Abs Path</h1>\n\n"]
end

test "use of absolute mote path for the layout" do
  Cuba.settings[:mote][:layout] = "./test/views/custom_layout.mote"

  _, _, body = Cuba.call({ "PATH_INFO" => "/", "SCRIPT_NAME" => "" })

  assert_response body, ["<title>Custom Layout: Hola</title>\n<h1>Home</h1>\n\n"]
end
