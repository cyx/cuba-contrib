class Cuba
  module TextHelpers
    def markdown(str)
      require "bluecloth"

      BlueCloth.new(str).to_html
    end

    def truncate(str, length, ellipses = "...")
      return str if !str || str.length <= length

      sprintf("%.#{length}s#{ellipses}", str)
    end

    def nl2br(str)
      str.to_s.gsub(/\n|\r\n/, "<br>")
    end

    def currency(amount, unit = "$")
      "#{unit} %.2f" % amount
    end

    def titlecase(str)
      str.to_s.tr("_", " ").gsub(/(^|\s)([a-z])/) { |char| char.upcase }
    end

    def humanize(str)
      titlecase(str.to_s.tr("_", " ").gsub(/_id$/, ""))
    end

    def underscore(str)
      str.gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').downcase
    end
  end
end
