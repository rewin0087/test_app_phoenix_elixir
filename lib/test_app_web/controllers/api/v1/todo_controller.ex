defmodule TestAppWeb.Api.V1.TodoController do
  use TestAppWeb, :controller

  alias TestApp.Excercise
  alias TestApp.Excercise.Todo

  action_fallback TestAppWeb.FallbackController

  def index(conn, _params) do
    todos = Excercise.list_todos()
    render(conn, "index.json", todos: todos)
  end

  def create(conn, %{"todo" => todo_params}) do
    with {:ok, %Todo{} = todo} <- Excercise.create_todo(todo_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", api/v1_todo_path(conn, :show, todo))
      |> render("show.json", todo: todo)
    end
  end

  def show(conn, %{"id" => id}) do
    todo = Excercise.get_todo!(id)
    render(conn, "show.json", todo: todo)
  end

  def update(conn, %{"id" => id, "todo" => todo_params}) do
    todo = Excercise.get_todo!(id)

    with {:ok, %Todo{} = todo} <- Excercise.update_todo(todo, todo_params) do
      render(conn, "show.json", todo: todo)
    end
  end

  def delete(conn, %{"id" => id}) do
    todo = Excercise.get_todo!(id)
    with {:ok, %Todo{}} <- Excercise.delete_todo(todo) do
      send_resp(conn, :no_content, "")
    end
  end
end
