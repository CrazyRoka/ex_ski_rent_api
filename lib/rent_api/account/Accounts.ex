defmodule RentApi.Accounts do
  alias RentApi.Accounts.User
  alias RentApi.Repo

  def create_user(params) do
    User.changeset(%User{}, params)
    |> Repo.insert()
  end

  def delete_user(user = %User{}) do
    Repo.delete(user)
  end

  def update_user(user, params) do
    user
    |> User.changeset(params)
    |> Repo.update()
  end

  def new_user do
    User.changeset(%User{}, %{})
  end
end
