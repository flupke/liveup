defmodule Liveup.Secrets do
  use AshAuthentication.Secret

  def secret_for([:authentication, :tokens, :signing_secret], Liveup.Accounts.User, _opts) do
    Application.fetch_env(:liveup, :token_signing_secret)
  end
end
