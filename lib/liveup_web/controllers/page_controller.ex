defmodule LiveupWeb.PageController do
  use LiveupWeb, :controller
  alias Liveup.Schedule

  def home(conn, _params) do
    events = Schedule.group_events_by_day_then_scene()
    render(conn, :home, layout: false, events: events)
  end

  def admin(conn, _params) do
    render(conn, :admin)
  end
end
