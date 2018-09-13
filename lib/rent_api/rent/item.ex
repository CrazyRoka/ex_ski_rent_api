defmodule RentApi.Rent.Item do
  use Ecto.Schema
  import Ecto.Changeset
  alias RentApi.Account.User
  alias RentApi.Rent.Review
  import Ecto.Query, only: [from: 2]

  schema "rent_items" do
    field :daily_price_cents, :integer
    field :name, :string
    belongs_to :owner, User
    has_one :review, Review
    has_one :city, through: [:owner, :city]

    timestamps()
  end

  def changeset(items, attrs) do
    items
    |> cast(attrs, [:name, :daily_price_cents])
    |> validate_required([:name, :daily_price_cents, :owner])
    |> foreign_key_constraint(:owner)
    |> validate_number(:daily_price_cents, greater_than_or_equal_to: 0)
  end

  def by_city(query, cities) do
    from item in query,
    join: owner in User,
    where: owner.id == item.owner_id and owner.city_id in ^cities
  end

  def by_users(query, users) do
    from item in query,
    where: item.owner_id in ^users
  end
end
