require "mote"

class Cuba
  module Mote
    include ::Mote::Helpers

    def self.setup(app)
      app.plugin Cuba::Settings

      app.set :views,  File.expand_path("views", Dir.pwd)
      app.set :layout, "layout"
    end

    def partial(template, locals = {})
      mote(mote_path(template), locals)
    end

    def view(template, locals = {}, layout = settings.layout)
      raise NoLayout.new(self) unless layout

      partial(layout, locals.merge(mote_vars(partial(template, locals))))
    end

    def mote_path(template)
      return template if template.end_with?(".mote")

      File.expand_path("#{template}.mote", settings.views)
    end

    def mote_vars(content)
      { content: content, session: session }
    end

    class NoLayout < StandardError
      attr :instance

      def initialize(instance)
        @instance = instance
      end

      def message
        "Missing Layout: Try doing #{instance.class}.set :layout, 'layout'"
      end
    end
  end
end