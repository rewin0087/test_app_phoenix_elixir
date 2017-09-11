defmodule TestApp.Blogs.Comment do
  use Ecto.Schema
  import Ecto.Changeset
  alias TestApp.Blogs.{Comment, Post}
  alias TestApp.Accounts.User

  schema "comments" do
    field :message, :string
    belongs_to :user, User, foreign_key: :user_id
    belongs_to :post, Post, foreign_key: :post_id

    timestamps()
  end

  @doc false
  def changeset(%Comment{} = comment, attrs) do
    comment
    |> cast(attrs, [:message, :user_id, :post_id])
    |> validate_required([:message, :user_id, :post_id])
  end
end
