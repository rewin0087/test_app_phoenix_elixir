defmodule TestApp.Comment do
  use TestApp.Web, :model

  schema "comments" do
    field :message, :string
    belongs_to :user, TestApp.User, foreign_key: :user_id
    belongs_to :post, TestApp.Post, foreign_key: :post_id

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:message])
    |> validate_required([:message])
  end
end
