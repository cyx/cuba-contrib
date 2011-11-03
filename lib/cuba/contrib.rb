class Cuba
  CONTRIB_ROOT = File.expand_path("../../", File.dirname(__FILE__))

  def self.plugin(mixin)
    include mixin
    extend  mixin::ClassMethods if defined?(mixin::ClassMethods)

    mixin.setup(self) if mixin.respond_to?(:setup)
  end

  # TODO: remove this as soon as cuba core implements this.
  def session
    env["rack.session"]
  end

  autoload :Prelude,    "cuba/contrib/prelude"
  autoload :Rendering,  "cuba/contrib/rendering"
  autoload :Settings,   "cuba/contrib/settings"
  autoload :Mote,       "cuba/contrib/mote"
  autoload :TextHelpers, "cuba/contrib/text_helpers"
  autoload :FormHelpers, "cuba/contrib/form_helpers"
end