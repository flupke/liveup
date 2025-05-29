defmodule Liveup.Schedule do
  @moduledoc """
  The Schedule context.
  """

  import Ecto.Query, warn: false
  alias Liveup.Repo

  alias Liveup.Schedule.Event
  alias Liveup.Locations.Scene

  @doc """
  Returns the list of events.

  ## Examples

      iex> list_events()
      [%Event{}, ...]

  """
  def list_events do
    Event
    |> order_by(asc: :start)
    |> Repo.all()
  end

  def group_events_by_day_then_scene do
    from(e in Event,
      preload: [:scene],
      order_by: [asc: e.start]
    )
    |> Repo.all()
    |> Enum.chunk_by(fn event ->
      event.start |> shift_for_grouping() |> NaiveDateTime.to_date()
    end)
    |> Enum.map(fn day_events ->
      day_events =
        day_events |> Enum.sort_by(fn event -> {-event.scene.priority, event.scene_id} end)

      first_day_event = hd(day_events)
      day_date = NaiveDateTime.to_date(first_day_event.start)

      day_events =
        day_events
        |> Enum.chunk_by(fn event -> event.scene_id end)
        |> Enum.map(fn scene_events ->
          first_event = hd(scene_events)
          {first_event.scene, scene_events}
        end)

      {day_date, day_events}
    end)
  end

  defp shift_for_grouping(datetime) do
    datetime |> NaiveDateTime.shift(hour: -7)
  end

  def list_scene_events(%Scene{} = scene) do
    from(e in Event,
      preload: [:scene],
      left_join: s in assoc(e, :scene),
      where: s.id == ^scene.id,
      order_by: [asc: e.start],
      select: e
    )
    |> Repo.all()
  end

  @doc """
  Gets a single event.

  Raises `Ecto.NoResultsError` if the Event does not exist.

  ## Examples

      iex> get_event!(123)
      %Event{}

      iex> get_event!(456)
      ** (Ecto.NoResultsError)

  """
  def get_event!(id), do: Repo.get!(Event, id)

  @doc """
  Creates a event.

  ## Examples

      iex> create_event(%{field: value})
      {:ok, %Event{}}

      iex> create_event(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_event(attrs \\ %{}) do
    %Event{}
    |> Event.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a event.

  ## Examples

      iex> update_event(event, %{field: new_value})
      {:ok, %Event{}}

      iex> update_event(event, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_event(%Event{} = event, attrs) do
    event
    |> Event.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a event.

  ## Examples

      iex> delete_event(event)
      {:ok, %Event{}}

      iex> delete_event(event)
      {:error, %Ecto.Changeset{}}

  """
  def delete_event(%Event{} = event) do
    Repo.delete(event)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking event changes.

  ## Examples

      iex> change_event(event)
      %Ecto.Changeset{data: %Event{}}

  """
  def change_event(%Event{} = event, attrs \\ %{}) do
    Event.changeset(event, attrs)
  end
end
