class Cuba
  CONTRIB_ROOT = File.expand_path("../../", File.dirname(__FILE__))

  autoload :Prelude,     "cuba/contrib/prelude"
  autoload :Rendering,   "cuba/contrib/rendering"
  autoload :Mote,        "cuba/contrib/mote"
  autoload :Settings,    "cuba/contrib/settings"
  autoload :TextHelpers, "cuba/contrib/text_helpers"
  autoload :FormHelpers, "cuba/contrib/form_helpers"
end
