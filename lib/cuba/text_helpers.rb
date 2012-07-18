class Cuba
  module TextHelpers
    def markdown(str)
      Markdown.new(str).to_html
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

    def delimit(number, delimiter = ",")
      number.to_s.gsub(%r{(\d)(?=(\d\d\d)+(?!\d))}, "\\1#{delimiter}")
    end

    def titlecase(str)
      res = str.to_s.dup
      res.tr!("_", " ")
      res.gsub!(/(^|\s)([a-z])/) { |char| char.upcase }
      res
    end

    def underscore(str)
      res = str.to_s.dup
      res.gsub!(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
      res.gsub!(/([a-z\d])([A-Z])/,'\1_\2')
      res.downcase!
      res
    end
  end
end
