defmodule RentApiWeb.UserControllerTest do
  use RentApiWeb.ConnCase
  import RentApi.Factory
  alias RentApi.Accounts.User
  alias RentApi.Accounts
  alias RentApi.Repo

  describe "create/2" do
    @valid_params %{
      name: "test",
      email: "test@test",
      password: "testtesttest",
      balance: 12345
    }

    test "Creates user if attributes are valid", %{conn: conn} do
      create_path = user_path(conn, :create, user: @valid_params)
      response = build_conn() |> post(create_path) |> json_response(201)
      assert response == Poison.encode!(%{"user": User.changeset(%User{}, @valid_params)})
    end

    test "Returns an error if attributes are invalid", %{conn: conn} do
      create_path = user_path(conn, :create, user: %{@valid_params | name: ""})
      response = build_conn() |> post(create_path) |> json_response(403)
      assert response == %{"error" => ["Item not found"]}
    end
  end
end
