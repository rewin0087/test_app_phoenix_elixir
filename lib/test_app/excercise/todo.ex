defmodule TestApp.Excercise.Todo do
  use Ecto.Schema
  import Ecto.Changeset
  alias TestApp.Excercise.Todo


  schema "todos" do
    field :description, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%Todo{} = todo, attrs) do
    todo
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
