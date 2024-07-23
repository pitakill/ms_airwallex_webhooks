defmodule MsAirwallexWebhooksWeb.HealthCheck do
  @moduledoc """
  Health check controller for CI porpuses
  """

  use MsAirwallexWebhooksWeb, :controller

  @doc """
  Health check endpoint for CI purposes
  """
  def health_check(conn, _params) do
    conn
    |> put_status(200)
    |> json(%{message: "OK"})
  end
end
