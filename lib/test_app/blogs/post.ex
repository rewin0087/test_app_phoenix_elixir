defmodule TestApp.Blogs.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias TestApp.Blogs.{Post, Comment}
  alias TestApp.Accounts.User

  schema "posts" do
    field :description, :string
    field :title, :string
    belongs_to :user, User, foreign_key: :user_id
    has_many :comments, Comment

    timestamps()
  end

  @doc false
  def changeset(%Post{} = post, attrs) do
    post
    |> cast(attrs, [:title, :description, :user_id])
    |> validate_required([:title, :description, :user_id])
  end
end
