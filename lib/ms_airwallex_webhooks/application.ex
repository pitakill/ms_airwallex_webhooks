defmodule MsAirwallexWebhooks.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      MsAirwallexWebhooksWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:ms_airwallex_webhooks, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: MsAirwallexWebhooks.PubSub},
      # Start a worker by calling: MsAirwallexWebhooks.Worker.start_link(arg)
      # {MsAirwallexWebhooks.Worker, arg},
      # Start to serve requests, typically the last entry
      MsAirwallexWebhooksWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MsAirwallexWebhooks.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MsAirwallexWebhooksWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
