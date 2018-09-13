defmodule RentApi.Rent.Booking do
  use Ecto.Schema
  alias RentApi.Account.User
  alias RentApi.Rent.Item
  alias RentApi.Repo
  import Ecto.Changeset
  import Ecto.Query, only: [from: 2]


  schema "rent_bookings" do
    field :cost_cents, :integer, default: 0
    field :end_date, Timex.Ecto.DateTime
    field :start_date, Timex.Ecto.DateTime
    belongs_to :item, Item
    belongs_to :renter, User

    timestamps()
  end

  @doc false
  def changeset(booking, attrs) do
    booking
    |> cast(attrs, [:start_date, :end_date, :cost_cents])
    |> validate_required([:cost_cents, :item, :renter])
    |> validate_number(:cost_cents, greater_than_or_equal_to: 0)
    |> validate_dates()
  end

  defp validate_dates(changeset) do
    start_date = get_field(changeset, :start_date)
    end_date = get_field(changeset, :end_date)
    case {start_date, end_date} do
      {nil, nil} -> changeset
      {nil, _} -> add_error(changeset, :date, "Incorrect dates")
      {_, nil} -> add_error(changeset, :date, "Incorrect dates")
      {start, finish} ->
        if :gt == DateTime.compare(start, finish) do
          add_error(changeset, :date, "Incorrect dates")
        else
          changeset
        end
    end
  end

  def by_items(query, items) do
    from booking in query,
    where: booking.item_id in ^items
  end

  def by_renters(query, renters) do
    from booking in query,
    where: booking.renter_id in ^renters
  end

  def by_item_owners(query, owners) do
    from booking in query,
    join: item in Item,
    where: item.id == booking.item_id and item.owner_id in ^owners
  end
end
