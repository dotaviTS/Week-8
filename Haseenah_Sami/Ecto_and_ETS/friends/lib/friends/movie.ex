defmodule Friends.Movie do
  use Ecto.Schema

  schema "movies" do
    field :title, :string
    field :tagline, :string
    has_many :character, Friends.Character
    has_one :distributor, Friends.Distributor # I'm new!
    many_to_many :actor, Friends.Actor, join_through: "movies_actors" # I'm new!
  end
end
