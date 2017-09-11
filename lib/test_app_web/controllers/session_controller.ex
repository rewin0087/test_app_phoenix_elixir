defmodule TestAppWeb.SessionController do
  use TestAppWeb, :controller

  alias TestApp.Accounts
  alias TestApp.Accounts.User
  alias TestApp.Auth

  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"user" => %{"email" => email, "password" => password}}) do

    case Auth.login_by_email_and_pass(conn, email, password) do
      {:ok, conn} ->
        conn
        |> put_flash(:info, "You’re now logged in!")
        |> redirect(to: post_path(conn, :index))
      {:error, _reason, conn} ->
        conn
        |> put_flash(:error, "Invalid email/password combination")
        |> render("new.html")
    end
  end

  def delete(conn, _params) do
    conn
    |> Auth.logout
    |> put_flash(:info, "Successfully logged out!")
    |> redirect(to: session_path(conn, :new))
  end

end
