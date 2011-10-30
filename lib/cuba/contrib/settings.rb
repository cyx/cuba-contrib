class Cuba
  module Settings
    def settings
      self.class
    end

    module ClassMethods
      def set(key, value)
        metaclass.send :attr_accessor, key

        send :"#{key}=", value
      end

    private
      def metaclass
        class << self; self; end
      end
    end
  end
end