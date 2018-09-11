defmodule RentApi.Rent.Booking do
  use Ecto.Schema
  import Ecto.Changeset


  schema "rent_bookings" do
    field :cost_cents, :integer, default: 0
    field :end_date, Timex.Ecto.DateTime
    field :start_date, Timex.Ecto.DateTime
    field :item, :id
    field :renter, :id

    timestamps()
  end

  @doc false
  def changeset(booking, attrs) do
    booking
    |> cast(attrs, [:start_date, :end_date, :cost_cents, :item, :renter])
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
end
