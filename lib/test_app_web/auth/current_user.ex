defmodule TestApp.CurrentUser do
  import Plug.Conn
  import Guardian.Plug

  def init(opts), do: opts

  def call(conn, _opts) do
    current_user = current_resource(conn)
    assign(conn, :current_user, current_user)
  end

  def resource(conn) do
    conn.assigns.current_user
  end

  def id(conn, str \\ false) do
    id = resource(conn).id

    case str do
      true ->
        to_string(id)
      false ->
        id
    end
  end
end
