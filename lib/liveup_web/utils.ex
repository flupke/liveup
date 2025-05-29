defmodule LiveupWeb.Utils do
  def format_event_time(datetime) do
    if datetime.minute == 0 do
      datetime |> Calendar.strftime("%Hh")
    else
      datetime |> Calendar.strftime("%Hh%M")
    end
  end
end
