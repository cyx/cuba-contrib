require 'r18n-core'

class Cuba
  module I18N
    include R18n::Helpers

    def self.setup(app)
      app.plugin Cuba::Settings
      app.set :default_locale, 'en'
      app.set :translations, File.join(Dir.pwd, 'i18n')
      ::R18n::Filters.off :untranslated
      ::R18n::Filters.on :untranslated_html
    end

    def set_locale(req, force_default = false)
      ::R18n.set do
        ::R18n::I18n.default = settings.default_locale
        locale = get_locale_from_host
        # You can add support for path language info :) Just do it and pull request it ;)
        # locale = get_locale_from_path if locale.nil?
        if locale.nil? and not force_default
          locales = ::R18n::I18n.parse_http req.env['HTTP_ACCEPT_LANGUAGE']
          if req.params['locale']
            locales.insert 0, req.params['locale']
          elsif req.session['locale']
            locales.insert 0, req.session['locale']
          end
        else
          locales = []
          locales << locale
          locales << settings.default_locale
        end
        ::R18n::I18n.new locales, settings.translations
      end
    end

    def get_locale_from_host
      # auxiliar method to get locale from the subdomain (assuming it is a valid locale).
      data = req.host.split('.')[0]
      data if ::R18n::Locale.exists? data
    end
  end
end

module R18n
  class I18n
    def &(name)
      # auxiliar method to get translations with ids as strings obtained from database, methods, etc.
      destiny = self
      name.to_s.split('.').each do |step|
        destiny = destiny.send step
      end
      destiny
    end
  end
end

