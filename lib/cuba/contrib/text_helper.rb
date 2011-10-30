require "bluecloth"

class Cuba
  module TextHelper
    def markdown(str)
      BlueCloth.new(str).to_html
    end

    def truncate(str, length, ellipses = "...")
      return str if str.length <= length

      sprintf("%.#{length}s#{ellipses}", str)
    end

    def nl2br(str)
      str.gsub(/\n|\r\n/, "<br>")
    end

    def currency(amount, unit = "$")
      "#{unit} %.2f" % amount
    end
  end
end