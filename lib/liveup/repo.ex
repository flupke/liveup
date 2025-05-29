defmodule Liveup.Repo do
  use Ecto.Repo,
    otp_app: :liveup,
    adapter: Ecto.Adapters.SQLite3
end
