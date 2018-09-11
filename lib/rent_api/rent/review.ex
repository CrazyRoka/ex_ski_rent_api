defmodule RentApi.Rent.Review do
  use Ecto.Schema
  import Ecto.Changeset


  schema "rent_reviews" do
    field :description, :string
    field :author, :id

    timestamps()
  end

  @doc false
  def changeset(review, attrs) do
    review
    |> cast(attrs, [:description])
    |> validate_required([:description])
  end
end
