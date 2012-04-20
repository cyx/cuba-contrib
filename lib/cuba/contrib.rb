class Cuba
  CONTRIB_ROOT = File.expand_path("../../", File.dirname(__FILE__))

  autoload :Prelude,     "cuba/contrib/prelude"
  autoload :Mote,        "cuba/contrib/mote"
  autoload :TextHelpers, "cuba/contrib/text_helpers"
  autoload :FormHelpers, "cuba/contrib/form_helpers"
  autoload :With       , "cuba/contrib/with"
end
