defmodule Liveup.Repo.Migrations.AddEventsScene do
  use Ecto.Migration

  def change do
    alter table(:events) do
      add :scene_id, references(:scenes, on_delete: :nilify_all, type: :uuid)
    end

    create index(:events, [:scene_id])
  end
end
