defmodule Liveup.Map do
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
end
