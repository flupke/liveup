defmodule LiveupWeb.PageController do
  use LiveupWeb, :controller

  def home(conn, _params) do
    schedule = Liveup.Schedule.get_days_with_events()
    render(conn, :home, layout: false, schedule: schedule)
  end
end
