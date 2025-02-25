defmodule Liveup.Map.Screen do
  use Ash.Resource,
    otp_app: :liveup,
    domain: Liveup.Map,
    data_layer: AshSqlite.DataLayer

  sqlite do
    table "screens"
    repo Liveup.Repo
  end

  actions do
    defaults [:read, :create, :update, :destroy]
    default_accept :*
  end

  attributes do
    uuid_primary_key :id

    attribute :name, :string do
      allow_nil? false
      public? true
    end
  end

  relationships do
    belongs_to :stage, Liveup.Map.Stage do
      allow_nil? false
      public? true
    end
  end
end
