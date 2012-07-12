class Cuba
  module With
    def with(dict = {})
      old, env["cuba.vars"] = vars, vars.merge(dict)
      yield
    ensure
      env["cuba.vars"] = old
    end

    def vars
      env["cuba.vars"] ||= {}
    end
  end
end
