defmodule RentApi.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias RentApi.Accounts.User
  alias RentApi.Rent.City
  alias RentApi.Rent.Booking
  alias RentApi.Rent.Review
  alias RentApi.Rent.Item

  @derive {Poison.Encoder, only: [:name, :email, :balance, :city_id]}
  schema "account_users" do
    field :name, :string
    field :email, :string, unique: true
    field :password, :string, virtual: true
    field :password_digest, :string
    field :balance, :integer
    belongs_to :city, City
    has_many :reviews, Review
    has_many :written_reviews, Review, foreign_key: :author_id
    has_many :items, Item, foreign_key: :owner_id
    has_many :bookings, Booking, foreign_key: :renter_id

    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :password_digest, :email, :balance, :password])
    |> validate_required([:name, :email, :balance])
    |> validate_number(:balance, greater_than_or_equal_to: 0)
    |> unique_constraint(:email)
    |> validate_password()
    |> put_password_hash()
  end

  defp put_password_hash(changeset = %{valid?: true, changes: %{password: password}}) do
    change(changeset, Comeonin.Bcrypt.add_hash(password, hash_key: :password_digest))
  end
  defp put_password_hash(changeset), do: changeset

  defp validate_password(changeset = %{data: %User{password: password}}), do: validate_length(changeset, :password, min: 8)
  defp validate_password(changeset = %{data: %User{password_digest: digest}}), do: changeset
  defp validate_password(changeset), do: validate_required(changeset, [:password])
end
