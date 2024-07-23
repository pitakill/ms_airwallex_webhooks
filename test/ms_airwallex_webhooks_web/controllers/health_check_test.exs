defmodule MsAirwallexWebhooksWeb.HealthCheckTest do
  use MsAirwallexWebhooksWeb.ConnCase, async: true

  test "GET /health", %{conn: conn} do
    conn = get(conn, "/api/health")
    {:ok, message} = Jason.encode(%{message: "OK"})

    assert conn.status == 200
    assert response(conn, 200) == message
  end
end
