defmodule RentApiWeb.UserController do
  use RentApiWeb, :controller
  alias RentApi.Repo
  alias RentApi.Accounts
  alias RentApi.Accounts.User

  def create(conn, params) do
    case Accounts.create_user(params["user"]) do
      {:ok, user} -> conn |> put_status(:created) |> render("show.json", user: user)
      {:error, changeset} -> conn |> put_status(:forbidden) |> render("errors.json", changeset: changeset)
    end
  end
end
