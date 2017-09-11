defmodule TestAppWeb.GuardianRestrictSessionHandler do
  import TestAppWeb.Router.Helpers
  def authenticated(conn, _params) do
    if conn.assigns.current_user do
      conn
      |> Phoenix.Controller.put_flash(:error, "You are logged in.")
      |> Phoenix.Controller.redirect(to: post_path(conn, :index))
    end
  end
end
