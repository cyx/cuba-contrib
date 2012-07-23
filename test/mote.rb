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

  on "partial-fu" do
    res.write partial("partial1")
  end

  on "abs_path" do
    res.write view("./test/views/custom/abs_path.mote", title: "Absolute")
  end

  def foo
    req.path
  end

  on "foo" do
    on "right" do
      res.write partial("foo-right")
    end

    on "wrong" do
      res.write partial("foo-wrong")
    end
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

test "partial-fu" do
  # We verify that nesting partials and contexts are passed along properly.
  _, _, body = Cuba.call({ "PATH_INFO" => "/partial-fu/A", "SCRIPT_NAME" => "" })
  assert_response body, ["partial1\npartial2\n/partial-fu/A\n\n"]

  # And that we're able to use req.path in the inner partials without an issue.
  _, _, body = Cuba.call({ "PATH_INFO" => "/partial-fu/B", "SCRIPT_NAME" => "" })
  assert_response body, ["partial1\npartial2\n/partial-fu/B\n\n"]
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

test "attempting to use defined variables in cuba context is a problem" do
  assert_raise NameError do
    Cuba.call({ "PATH_INFO" => "/foo/wrong", "SCRIPT_NAME" => "" })
  end

  _, _, body = Cuba.call({ "PATH_INFO" => "/foo/right", "SCRIPT_NAME" => "" })

  assert_response body, ["/foo/right\n"]
end
