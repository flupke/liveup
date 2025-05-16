defmodule Liveup.LocationsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Liveup.Locations` context.
  """

  @doc """
  Generate a scene.
  """
  def scene_fixture(attrs \\ %{}) do
    {:ok, scene} =
      attrs
      |> Enum.into(%{
        name: "some name",
        priority: 42
      })
      |> Liveup.Locations.create_scene()

    scene
  end
end
