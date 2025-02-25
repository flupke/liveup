defmodule Liveup.Schedule do
  use Ash.Domain,
    otp_app: :liveup,
    extensions: [AshAdmin.Domain]

  admin do
    show? true
  end

  resources do
    resource Liveup.Schedule.Day
    resource Liveup.Schedule.Event
  end
end
