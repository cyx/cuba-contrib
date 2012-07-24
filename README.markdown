# cuba-contrib

[Cuba][cuba] is probably one of the tiniest rack-based micro
frameworks around. Weighing in at only __138 LOC__, it has proven
itself to be a very resilient tool in various web application domains.
Check [the list of sites][cuba] built using Cuba in order to
grasp the endless possibilities.

## STEP 1: Cuba::Prelude

Cuba [does one thing, and it does it well][unix]. Cuba-contrib, on
the other hand, layers requirement-specific functionality on
top of it. This allows us to build simpler and lighter solutions.

To get started with `Cuba::Contrib`, install it using RubyGems:

``` bash
$ gem install cuba          # if you haven't already done so
$ gem install cuba-contrib
```

For the remainder of the examples below, we'll assume you
always put your main cuba application in `app.rb` and your
views in `views`.

``` bash
$ touch app.rb
$ mkdir views
```

Now you can require it in your application

``` ruby
require "cuba"
require "cuba/contrib"

Cuba.plugin Cuba::Prelude
```

`Cuba::Prelude` adds the basic stuff you'll need:

``` ruby
Cuba.define do
  on "about" do
    # same as encodeURIComponent in javascript land
    res.write urlencode("http://www.google.com")

    # basically an alias for Rack::Utils.escape_html
    res.write h("Cuba & Cuba Contrib")
  end
end
```

## STEP 2: Choose your templating

### Here comes a new challenger: Mote

We prefer to use our home-grown templating engine called
[Mote][mote]. We do that by simply loading the plugin `Cuba::Mote`:

``` ruby
require "cuba"
require "cuba/contrib"
require "mote"

Cuba.plugin Cuba::Mote

Cuba.define do
  on "home" do
    res.write view("home")
  end

  on "about" do
    res.write partial("about")
  end

  # Or you can use `render` as a shortcut to `res.write view(...)`.
  on "contact" do
    render("contact")
  end
end
```

This assumes that you have a `views` folder, containing a `home.mote`
and an `about.mote`. Your layout defaults to `layout.mote`.

### Classic templating needs

**Note**: as of Cuba 3.0, the plugin architecture of `cuba-contrib` has
been merged into the core codebase. The following example should work with
Cuba 3.0 without even requiring `cuba-contrib`.

``` ruby
require "cuba"
require "cuba/render"

Cuba.plugin Cuba::Render
Cuba.settings[:render][:template_engine] = "haml"

Cuba.define do
  on "home" do
    res.write view("home") # renders views/home.haml
  end

  on "about" do
    res.write partial("about") # renders views/about.haml
  end
end
```

## STEP 3: Make your own plugins

Authoring your own plugins is pretty straightforward.

``` ruby
require "bluecloth"

module MyOwnHelper
  def markdown(str)
    Markdown.new(str).to_html
  end
end

Cuba.plugin MyOwnHelper
```

that's the simplest kind of plugin you'll write. In fact,
that's exactly how the `markdown` helper is written in
`Cuba::TextHelpers`.

A more complicated plugin for example, will make use of
`Cuba.settings` to provide default values:

``` ruby
module MarkdownView
  def self.setup(app)
    app.settings[:markdown_view] ||= {}
    app.settings[:markdown_view][:views] = "markdown"
  end

  def markdown_view(template)
    data = File.read("#{settings[:markdown_view][:views]}/#{template}.markdown")

    res.write Markdown.new(data).to_html
  end
end

Cuba.plugin MarkdownView
```

[cuba]: http://cuba.is
[mote]: http://github.com/soveran/mote
[unix]: http://en.wikipedia.org/wiki/Unix_philosophy
