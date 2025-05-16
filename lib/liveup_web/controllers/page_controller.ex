defmodule LiveupWeb.PageController do
  use LiveupWeb, :controller
  alias Liveup.Schedule

  def home(conn, _params) do
    events = Schedule.list_events_by_day() |> IO.inspect()
    render(conn, :home, layout: false, events: events)
  end

  def admin(conn, _params) do
    render(conn, :admin)
  end
end
