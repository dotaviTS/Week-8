defmodule Friends.Movie do
  use Ecto.Schema

  schema "movies" do
    field :title, :string
    field :tagline, :string
    has_many :character, Friends.Character
    has_one :distributor, Friends.Distributor # I'm new!
  end
end
