defmodule Liveup.ScheduleFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Liveup.Schedule` context.
  """

  @doc """
  Generate a event.
  """
  def event_fixture(attrs \\ %{}) do
    {:ok, event} =
      attrs
      |> Enum.into(%{
        name: "some name",
        start: ~U[2025-05-15 18:58:00Z]
      })
      |> Liveup.Schedule.create_event()

    event
  end
end
