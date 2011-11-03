class Cuba
  module Rendering
    def self.setup(app)
      app.plugin Cuba::Settings
      app.set :template_engine, "erb"
      app.set :views, File.expand_path("views", Dir.pwd)
    end

    def view(template, locals = {})
      partial("layout", { content: partial(template, locals) }.merge(locals))
    end

    def partial(template, locals = {})
      render("#{settings.views}/#{template}.#{settings.template_engine}", locals)
    end
  end
end