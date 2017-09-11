defmodule TestApp.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias TestApp.Accounts.User
  alias TestApp.Blogs.{Post, Comment}

  schema "users" do
    field :name, :string
    field :username, :string
    field :email, :string
    field :password, :string
    has_many :posts, Post
    has_many :comments, Comment 

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :username, :email, :password])
    |> validate_required([:name, :username, :email, :password])
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/@/)
    |> validate_confirmation(:password, message: "Password not match!")
    |> unique_constraint(:username)
  end
end
