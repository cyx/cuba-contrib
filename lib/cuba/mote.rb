require "mote"

class Cuba
  module Mote
    include ::Mote::Helpers

    def self.setup(app)
      app.settings[:mote] ||= {}
      app.settings[:mote][:views]  ||= File.expand_path("views", Dir.pwd)
      app.settings[:mote][:layout] ||= "layout"
    end

    def partial(template, locals = {})
      mote(mote_path(template), locals.merge(this: self), TOPLEVEL_BINDING)
    end

    def view(template, locals = {}, layout = settings[:mote][:layout])
      raise NoLayout.new(self) unless layout

      partial(layout, locals.merge(mote_vars(partial(template, locals))))
    end

    def render(template, locals = {}, layout = settings[:mote][:layout])
      res.write view(template, locals, layout)
    end

    def mote_path(template)
      return template if template.end_with?(".mote")

      File.join(settings[:mote][:views], "#{template}.mote")
    end

    # DEPRECATED: this will be removed in a future version. Use the
    # `this` context variable instead.
    def mote_vars(content)
      { content: content }
    end

    class NoLayout < StandardError
      attr :instance

      def initialize(instance)
        @instance = instance
      end

      def message
        "Missing Layout: Try doing #{instance.class}.settings[:layout] = 'layout'"
      end
    end
  end
end
