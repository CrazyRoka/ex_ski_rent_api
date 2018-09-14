defmodule RentApi.Rent.City do
  use Ecto.Schema
  import Ecto.Changeset
  alias RentApi.Accounts.User

  schema "rent_cities" do
    field :name, :string
    has_many :citizens, User

    timestamps()
  end

  def changeset(city, attrs) do
    city
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
