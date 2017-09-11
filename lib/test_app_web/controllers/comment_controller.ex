defmodule TestAppWeb.CommentController do
  use TestAppWeb, :controller

  alias TestApp.Blogs
  alias TestAppWeb.PostView

  def create(conn, %{"comment" => comment_params, "post_id" => post_id}) do
    post = Blogs.get_post!(post_id)
    case Blogs.create_comment(comment_params) do
      {:ok, _comment} ->
        conn
        |> put_flash(:info, "Comment posted.")
        |> redirect(to: post_path(conn, :show, post))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, PostView, "show.html", changeset: changeset, post: post)
    end
  end
end
