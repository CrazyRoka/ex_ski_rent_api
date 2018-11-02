defmodule RentApiWeb.ItemControllerTest do
  use RentApiWeb.ConnCase
  import RentApi.Factory
  alias RentApi.Rent.Item
  alias RentApi.Repo

  describe "index/2" do
    test "Responds with paginated Items", %{conn: conn} do
      items = insert_list(13, :item) |> Enum.slice(0, 10)
      expected_output = %{items: items, total_count: 13} |> Poison.encode!()
      responce = build_conn() |> get(item_path(conn, :index)) |> json_response(200)
      assert expected_output == responce
    end

    test "Responds with second page Items", %{conn: conn} do
      items = insert_list(13, :item) |> Enum.slice(5, 5)
      expected_output = %{items: items, total_count: 13} |> Poison.encode!()
      response = build_conn() |> get(item_path(conn, :index, page_size: 5, page: 2))
                      |> json_response(200)
      assert expected_output == response
    end
  end

  describe "create/2" do
    @valid_params %{
      name: "test",
      daily_price_cens: 123
    }

    test "Creates item if attributes are valid", %{conn: conn} do
      create_path = item_path(conn, :create, registration: @valid_params)
      response = build_conn() |> post(create_path) |> json_response(200)
    end

    test "Returns an error if attributes are invalid", %{conn: conn} do
      create_path = item_path(conn, :create, item: %{@valid_params | name: ""})
      response = build_conn() |> post(create_path) |> json_response(200)
    end
  end

  describe "show/2" do
    test "Responds with item info if the item is found", %{conn: conn} do
      item = insert(:item)
      expected_output = %{item: item} |> Poison.encode!()
      response = build_conn() |> get(item_path(conn, :show, item.id)) |> json_response(200)
      assert expected_output == response
    end

    test "Responds with a message indicating item not found", %{conn: conn} do
      response = build_conn() |> get(item_path(conn, :show, -1)) |> json_response(404)
      assert response == %{"errors" => ["Not found"]}
    end
  end

  describe "update/2" do
    setup do
      item = insert(:item)
      {:ok, item: item}
    end

    @valid_params %{
      name: "test",
      daily_price_cents: 321
    }

    @invalid_params %{
      name: ""
    }

    test "Edits item if attributes are valid", %{item: item} do
      patch_path = item_path(build_conn(), :update, item.id, item: @valid_params)
      response = build_conn() |> patch(patch_path) |> json_response(200)
      assert response == Poison.encode!(%{"item": %Item{item | name: "test", daily_price_cents: 321}})
    end

    test "Error if attributes are invalid", %{item: item}  do
      patch_path = item_path(build_conn(), :update, item.id, item: @invalid_params)
      response = build_conn() |> patch(patch_path) |> json_response(403)
      assert response == %{"errors" => %{"name" => ["can't be blank"]}}
    end
  end

  describe "delete/2" do
    test "removes item" do
      item = insert(:item)
      response = build_conn() |> delete(item_path(conn, :delete, item.id)) |> json_response(200)
      assert response == %{"success" => "Item deleted"}
      assert Repo.get(Item, item.id) == nil
    end

    test "item not found" do
      delete_path = item_path(build_conn(), :delete, -1)
      response = build_conn() |> delete(delete_path) |> json_response(404)
      assert response == %{"error" => ["Item not found"]}
    end
  end
end
