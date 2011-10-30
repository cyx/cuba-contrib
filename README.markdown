# cuba-contrib

An extraction of all the useful code that we've been using
with Cuba so far.

## Helpers

Helpers are similar to Sinatra helpers. It provides only
methods that should be accessible within the request-response
context.

- Cuba::TextHelper
- Cuba::Prelude

## Plugins

Plugins are more heavyweight, and typically requires the
addition of class methods, as well as utilizing `Cuba::Settings`
to provide default configuration values.

- Cuba::Settings
- Cuba::Mote
