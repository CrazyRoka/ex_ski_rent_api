defmodule RentApi.Account.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias RentApi.Account.User


  schema "account_users" do
    field :balance, :integer
    field :email, :string, unique: true
    field :name, :string
    field :password_digest, :string
    field :password, :string, virtual: true

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

  defp validate_password(changeset = %{data: %User{password: password}}) do
    validate_length(changeset, :password, min: 8)
  end
  defp validate_password(changeset = %{data: %User{password_digest: digest}}) do
    changeset
  end
  defp validate_password(changeset), do: validate_required(changeset, [:password])
end
