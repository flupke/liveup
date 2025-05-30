defmodule Liveup.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    if Mix.target() != :host do
      db_path = "/data/liveup.db"

      if not File.exists?(db_path) do
        File.copy!(Application.app_dir(:liveup, "priv/repo/liveup.db"), db_path)
      end
    end

    children =
      [
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
      ] ++ children()

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

  if Mix.target() == :host do
    defp children() do
      [
        # Children that only run on the host
        # Starts a worker by calling: Liveup.Worker.start_link(arg)
        # {Liveup.Worker, arg},
      ]
    end
  else
    defp children() do
      # NOTE: work around to stop watchers on targets
      Application.get_env(:liveup, LiveupWeb.Endpoint)
      |> Keyword.put(:watchers, [])
      |> then(&Application.put_env(:liveup, LiveupWeb.Endpoint, &1))

      start_node()

      [
        # Children for all targets except host
        # Starts a worker by calling: Liveup.Worker.start_link(arg)
        # {Liveup.Worker, arg},
        {Liveup.DisplaySupervisor, []}
      ]
    end

    defp start_node() do
      {_, 0} = System.cmd("epmd", ~w"-daemon")
      {:ok, _pid} = Node.start(:"liveup@nerves.local")
      Node.set_cookie(Application.get_env(:mix_tasks_upload_hotswap, :cookie))
    end
  end
end
