defmodule Liveup.Accounts do
  use Ash.Domain, otp_app: :liveup, extensions: [AshAdmin.Domain]

  admin do
    show? true
  end

  resources do
    resource Liveup.Accounts.Token
    resource Liveup.Accounts.User
  end
end
