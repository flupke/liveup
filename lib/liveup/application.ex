defmodule Liveup.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      LiveupWeb.Telemetry,
      Liveup.Repo,
      {DNSCluster, query: Application.get_env(:liveup, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Liveup.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Liveup.Finch},
      # Start a worker by calling: Liveup.Worker.start_link(arg)
      # {Liveup.Worker, arg},
      # Start to serve requests, typically the last entry
      LiveupWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Liveup.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LiveupWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
