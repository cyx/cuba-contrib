class Cuba
  def self.helper(mixin)
    include mixin
  end

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
  autoload :Settings,   "cuba/contrib/settings"
  autoload :Mote,       "cuba/contrib/mote"
  autoload :TextHelper, "cuba/contrib/text_helper"
end