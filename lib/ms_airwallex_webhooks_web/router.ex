defmodule MsAirwallexWebhooksWeb.Router do
  use MsAirwallexWebhooksWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", MsAirwallexWebhooksWeb do
    pipe_through :api
  end
end
