defmodule RentApi.Rent.Review do
  use Ecto.Schema
  import Ecto.Changeset
  alias RentApi.Account.User
  alias RentApi.Rent.Item
  alias RentApi.Rent.ReviewsUsers
  alias RentApi.Rent.ReviewsItems

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
end
