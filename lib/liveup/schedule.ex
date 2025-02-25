defmodule Liveup.Schedule do
  require Ash.Query

  use Ash.Domain,
    otp_app: :liveup,
    extensions: [AshAdmin.Domain]

  admin do
    show? true
  end

  resources do
    resource Liveup.Schedule.Day
    resource Liveup.Schedule.Event
  end

  def get_days_with_events do
    days =
      Liveup.Schedule.Day
      |> Ash.read!()

    for day <- days do
      events =
        Liveup.Schedule.Event
        |> Ash.Query.filter(day_id == ^day.id)
        |> Ash.read!()

      {day, events}
    end
  end
end
