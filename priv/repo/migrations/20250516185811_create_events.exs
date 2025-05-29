defmodule Liveup.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :start, :naive_datetime
      add :end, :naive_datetime

      timestamps(type: :naive_datetime)
    end
  end
end
