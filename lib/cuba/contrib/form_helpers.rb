class Cuba
  module FormHelpers
    include Cuba::Prelude

    def cuba_contrib_partial(template, locals = {})
      partial(cuba_contrib_path("%s.mote" % template), locals)
    end

    def cuba_contrib_path(*args)
      File.join(Cuba::CONTRIB_ROOT, "views", *args)
    end

    def cuba_contrib_form(record)
      view(cuba_contrib_path("form"), model: record)
    end

    def select_options(pairs, selected = nil, prompt = nil)
      "".tap do |ret|
        ret << option_tag(prompt, "") if prompt

        pairs.each do |label, value|
          ret << option_tag(label, value, selected)
        end
      end
    end

    def option_tag(label, value, selected = nil)
      cuba_contrib_partial("option", selected: selected, value: value, label: label)
    end

    def datefield(model, field, hint = nil)
      input(model, field, hint) do
        cuba_contrib_partial("textfield",
          name: field_name(model, field),
          value: model.send(field),
          class: "date"
        )
      end
    end

    def textfield(model, field, hint = nil)
      input(model, field, hint) do
        cuba_contrib_partial("textfield",
          name: field_name(model, field),
          value: model.send(field)
        )
      end
    end

    def password_field(model, field, hint = nil)
      input(model, field, hint) do
        cuba_contrib_partial("password",
          name: field_name(model, field)
        )
      end
    end

    def filefield(model, field, hint = nil)
      input(model, field, hint) do
        cuba_contrib_partial("file",
          name: field_name(model, field)
        )
      end
    end

    def textarea(model, field, hint = nil)
      input(model, field, hint) do
        cuba_contrib_partial("textarea",
          name: field_name(model, field),
          value: model.send(field)
        )
      end
    end

    def dropdown(model, field, options, hint = nil)
      input(model, field, hint) do
        cuba_contrib_partial("select",
          name: field_name(model, field),
          options: select_options(options, model.send(field))
        )
      end
    end

    def input(model, field, hint)
      cuba_contrib_partial("field",
        label: humanize(field),
        input: yield,
        hint: hint,
        error: localize_errors(model, field).join(", ")
      )
    end

    def localize_errors(model, field)
      model.errors[field].map do |err|
        unless settings.localized_errors[err]
          raise "No localized error defined for: #{err}"
        end

        settings.localized_errors[err] % { field: humanize(field) }
      end
    end

    def field_name(model, field)
      "#{underscore(model.class.name)}[#{field}]"
    end
  end
end