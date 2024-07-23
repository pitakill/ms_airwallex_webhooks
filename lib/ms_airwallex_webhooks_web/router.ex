defmodule MsAirwallexWebhooksWeb.Router do
  use MsAirwallexWebhooksWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", MsAirwallexWebhooksWeb do
    pipe_through :api

    get "health", HealthCheck, :health_check
  end
end
