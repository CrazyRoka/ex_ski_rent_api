defmodule RentApi.Rent.Review do
  use Ecto.Schema
  import Ecto.Changeset
  alias RentApi.Accounts.User
  alias RentApi.Rent.Item
  alias RentApi.Rent.Booking
  alias RentApi.Repo

  schema "rent_reviews" do
    field :description, :string
    belongs_to :author, User
    belongs_to :item, Item
    belongs_to :user, User

    timestamps()
  end

  def changeset(review, attrs) do
    review
    |> cast(attrs, [:description])
    |> validate_required([:description, :author])
    |> validate_reviewable()
    |> validate_booking_history
  end

  defp validate_reviewable(changeset) do
    item = get_field(changeset, :item)
    user = get_field(changeset, :user)
    cond do
      item && user -> add_error(changeset, :reviewable, "can't review more than one object")
      item || user -> changeset
      true -> add_error(changeset, :reviewable, "must review something")
    end
  end

  defp validate_booking_history(changeset) do
    cond do
      get_field(changeset, :item) -> validate_item_history(changeset)
      get_field(changeset, :user) -> validate_user_history(changeset)
      true -> add_error(changeset, :reviewable, "you must review something")
    end
  end

  defp validate_item_history(changeset) do
    author_id = get_field(changeset, :author).id
    item_id = get_field(changeset, :item).id
    bookings = Booking
               |> Booking.by_items([item_id])
               |> Booking.by_renters([author_id])
               |> Repo.aggregate(:count, :id)

    if bookings == 0 do
      add_error(changeset, :item, "you didn't use this item before")
    else
      changeset
    end
  end

  defp validate_user_history(changeset) do
    author_id = get_field(changeset, :author).id
    owner_id = get_field(changeset, :user).id
    bookings = Booking |> Booking.by_item_owners([owner_id])
               |> Booking.by_renters([author_id])
               |> Repo.aggregate(:count, :id)

    if Enum.count(bookings) == 0 do
      add_error(changeset, :item, "you didn't use his items before")
    else
      changeset
    end
  end
end
