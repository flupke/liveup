defmodule LiveupWeb.Cldr do
  use Cldr,
    locales: ["fr", "en", "es"],
    providers: [Cldr.Number, Cldr.Calendar, Cldr.DateTime],
    gettext: LiveupWeb.Gettext
end
