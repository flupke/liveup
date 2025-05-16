defmodule Liveup.ScheduleFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Liveup.Schedule` context.
  """

  @doc """
  Generate a event.
  """
  def event_fixture(attrs \\ %{}) do
    scene = Liveup.LocationsFixtures.scene_fixture()

    {:ok, event} =
      attrs
      |> Enum.into(%{
        name: "some name",
        start: ~U[2025-05-15 18:58:00Z],
        scene_id: scene.id
      })
      |> Liveup.Schedule.create_event()

    event
  end
end
