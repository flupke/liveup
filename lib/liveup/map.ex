defmodule Liveup.Map do
  require Ash.Query

  use Ash.Domain,
    otp_app: :liveup,
    extensions: [AshAdmin.Domain]

  admin do
    show? true
  end

  resources do
    resource Liveup.Map.Stage
    resource Liveup.Map.Screen
  end

  def get_stages_with_screens do
    stages = Liveup.Map.Stage |> Ash.read!()

    for stage <- stages do
      screens = Liveup.Map.Screen |> Ash.Query.filter(stage_id == ^stage.id) |> Ash.read!()
      {stage, screens}
    end
  end

  def get_screen(id) do
    Liveup.Map.Screen |> Ash.get!(id)
  end
end
