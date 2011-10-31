require "uri"

class Cuba
  module Prelude
    def urlencode(str)
      URI.encode_www_form_component(str)
    end

    def escape_html(str)
      Rack::Utils.escape_html(str)
    end
    alias :h :escape_html
  end
end
