defmodule Liveup.Repo.Migrations.AddEventType do
  use Ecto.Migration

  def change do
    alter table(:events) do
      add :type, :string, null: false, default: ""
    end
  end
end
