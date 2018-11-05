defmodule RentApiWeb.SessionControllerTest do
  use RentApiWeb.ConnCase
  import RentApi.Factory
  alias RentApi.Accounts.User
  alias RentApi.Accounts
  alias RentApi.Repo

  describe "create/2" do
    setup do
      password = "123456789"
      user = insert(:user, password: password)
      {:ok, user: user, password: password}
    end

    test "Creates user if attributes are valid", %{conn: conn, user: user, password: password} do
      create_path = session_path(conn, :create, email: user.email, password: password)
      response = build_conn() |> post(create_path) |> json_response(201)
    end

    test "Returns an error if attributes are invalid", %{conn: conn} do
      create_path = user_path(conn, :create, user: %{@valid_params | name: ""})
      response = build_conn() |> post(create_path) |> json_response(403)
    end
  end

  describe "delete/2" do
    @valid_params %{
      name: "test",
      email: "test@test",
      password: "testtesttest",
      balance: 12345
    }

    test "Creates user if attributes are valid", %{conn: conn} do
      create_path = user_path(conn, :create, user: @valid_params)
      response = build_conn() |> post(create_path) |> json_response(201)
    end

    test "Returns an error if attributes are invalid", %{conn: conn} do
      create_path = user_path(conn, :create, user: %{@valid_params | name: ""})
      response = build_conn() |> post(create_path) |> json_response(403)
    end
  end

  describe "refresh/2" do
    @valid_params %{
      name: "test",
      email: "test@test",
      password: "testtesttest",
      balance: 12345
    }

    test "Creates user if attributes are valid", %{conn: conn} do
      create_path = user_path(conn, :create, user: @valid_params)
      response = build_conn() |> post(create_path) |> json_response(201)
    end

    test "Returns an error if attributes are invalid", %{conn: conn} do
      create_path = user_path(conn, :create, user: %{@valid_params | name: ""})
      response = build_conn() |> post(create_path) |> json_response(403)
    end
  end
end
