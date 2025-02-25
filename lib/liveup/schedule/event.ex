defmodule Liveup.Schedule.Event do
  use Ash.Resource,
    otp_app: :liveup,
    domain: Liveup.Schedule,
    data_layer: AshSqlite.DataLayer

  sqlite do
    table "events"
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

    attribute :time, :time do
      allow_nil? false
      public? true
    end
  end

  relationships do
    belongs_to :day, Liveup.Schedule.Day do
      allow_nil? false
      public? true
    end
  end
end
