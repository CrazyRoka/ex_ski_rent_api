defmodule RentApi.Rent.Item do
  use Ecto.Schema
  import Ecto.Changeset
  alias RentApi.Account.User
  alias RentApi.Rent.Review

  schema "rent_items" do
    field :daily_price_cents, :integer
    field :name, :string
    belongs_to :owner, User
    has_one :review, Review

    timestamps()
  end

  def changeset(items, attrs) do
    items
    |> cast(attrs, [:name, :daily_price_cents])
    |> validate_required([:name, :daily_price_cents, :owner])
    |> foreign_key_constraint(:owner)
    |> validate_number(:daily_price_cents, greater_than_or_equal_to: 0)
  end
end
