defmodule Liveup.Schedule.Event do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "events" do
    field :name, :string
    field :start, :naive_datetime
    field :end, :naive_datetime
    field :type, :string, default: ""
    belongs_to :scene, Liveup.Locations.Scene

    timestamps(type: :naive_datetime)
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:name, :start, :end, :type, :scene_id])
    |> validate_required([:name, :start, :end, :scene_id])
    |> assoc_constraint(:scene)
  end
end
