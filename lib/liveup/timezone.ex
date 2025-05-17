defmodule Liveup.Timezone do
  def timezone() do
    Application.get_env(:liveup, :timezone)
  end

  def to_local(datetime) do
    DateTime.shift_zone!(datetime, timezone())
  end

  def from_local(datetime) when is_struct(datetime, DateTime) do
    DateTime.shift_zone!(datetime, "Etc/UTC")
  end

  def from_local(datetime) when is_struct(datetime, NaiveDateTime) do
    DateTime.from_naive!(datetime, timezone())
    |> from_local()
  end

  def from_local(datetime) when is_binary(datetime) do
    {:ok, datetime} = Ecto.Type.cast(:naive_datetime, datetime)

    datetime
    |> from_local()
  end
end
