defmodule Liveup.ScheduleTest do
  use Liveup.DataCase

  alias Liveup.Schedule
  alias Liveup.Timezone

  describe "events" do
    alias Liveup.Schedule.Event

    import Liveup.ScheduleFixtures
    import Liveup.LocationsFixtures

    @invalid_attrs %{name: nil, start: nil}

    test "list_events/0 returns all events" do
      event = event_fixture()
      assert Schedule.list_events() == [event]
    end

    test "get_event!/1 returns the event with given id" do
      event = event_fixture()
      assert Schedule.get_event!(event.id) == event
    end

    test "create_event/1 with valid data creates a event" do
      scene = Liveup.LocationsFixtures.scene_fixture()
      valid_attrs = %{name: "some name", start: ~U[2025-05-15 18:58:00Z], scene_id: scene.id}

      assert {:ok, %Event{} = event} = Schedule.create_event(valid_attrs)
      assert event.name == "some name"
      assert event.start == ~U[2025-05-15 18:58:00Z] |> Timezone.to_local()
    end

    test "create_event/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Schedule.create_event(@invalid_attrs)
    end

    test "update_event/2 with valid data updates the event" do
      event = event_fixture()
      update_attrs = %{name: "some updated name", start: ~U[2025-05-16 18:58:00Z]}

      assert {:ok, %Event{} = event} = Schedule.update_event(event, update_attrs)
      assert event.name == "some updated name"
      assert event.start == ~U[2025-05-16 18:58:00Z] |> Timezone.to_local()
    end

    test "update_event/2 with invalid data returns error changeset" do
      event = event_fixture()
      assert {:error, %Ecto.Changeset{}} = Schedule.update_event(event, @invalid_attrs)
      assert event == Schedule.get_event!(event.id)
    end

    test "delete_event/1 deletes the event" do
      event = event_fixture()
      assert {:ok, %Event{}} = Schedule.delete_event(event)
      assert_raise Ecto.NoResultsError, fn -> Schedule.get_event!(event.id) end
    end

    test "change_event/1 returns a event changeset" do
      event = event_fixture()
      assert %Ecto.Changeset{} = Schedule.change_event(event)
    end

    test "group_events_by_day_then_scene/0 groups events by day then scene" do
      scene1 = scene_fixture(%{name: "scene1", priority: 1})
      scene2 = scene_fixture(%{name: "scene2", priority: 100})

      event1 =
        event_fixture(%{start: ~U[2025-05-14 18:58:00Z], scene_id: scene1.id})
        |> Repo.preload(:scene)

      event2 =
        event_fixture(%{start: ~U[2025-05-15 18:58:00Z], scene_id: scene1.id})
        |> Repo.preload(:scene)

      event3 =
        event_fixture(%{start: ~U[2025-05-15 17:58:00Z], scene_id: scene2.id})
        |> Repo.preload(:scene)

      assert Schedule.group_events_by_day_then_scene() == [
               {~D[2025-05-14], [{scene1, [event1]}]},
               {~D[2025-05-15], [{scene2, [event3]}, {scene1, [event2]}]}
             ]
    end
  end
end
