defmodule LiveupWeb.PageController do
  use LiveupWeb, :controller

  def home(conn, _params) do
    schedule = Liveup.Schedule.get_days_with_events()
    render(conn, :home, layout: false, schedule: schedule)
  end

  def screens(conn, _params) do
    stages = Liveup.Map.get_stages_with_screens()
    render(conn, :screens, layout: false, stages: stages)
  end

  def screen(conn, %{"id" => id}) do
    screen = Liveup.Map.get_screen(id)
    render(conn, :screen, layout: false, screen: screen)
  end
end
