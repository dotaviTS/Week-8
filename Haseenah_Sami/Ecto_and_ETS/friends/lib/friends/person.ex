defmodule Friends.Person do
  use Ecto.Schema
  import Ecto.Changeset

  schema "people" do
    field :name, :string
    field :age, :integer, default: 0
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:name, :age])
    |> validate_required([:name])
  end
end
