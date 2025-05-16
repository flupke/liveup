defmodule Liveup.Locations.Scene do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "scenes" do
    field :name, :string
    field :priority, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(scene, attrs) do
    scene
    |> cast(attrs, [:name, :priority])
    |> validate_required([:name, :priority])
  end
end
