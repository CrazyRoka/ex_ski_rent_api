defmodule RentApiWeb.ItemController do
  use RentApiWeb, :controller
  alias RentApi.Repo
  alias RentApi.Rent.Item


  def index(conn, params) do
    page = Item |> Repo.paginate(params)
    render(conn, "index.json", items: page.entries, total_count: page.total_entries)
  end

  def show(conn, %{"id" => id}) do
    case Repo.get(Item, id) do
      nil -> conn |> put_status(:not_found) |> json(%{errors: "not found"})
      item -> render(conn, "show.json", item: item)
    end
  end

  def create(conn, params) do

  end

  def update(conn, %{"id" => id, "item" => item_params}) do
    case Repo.get(Item, id) do
      nil -> conn |> put_status(:not_found) |> json(%{errors: "not found"})
      item ->
        updated_item = item |> Item.changeset(item_params) |> Repo.update()
        IO.inspect(updated_item)
        render(conn, "show.json", item: item)
    end
  end

  def delete(conn, %{"id" => id}) do
    case Repo.get(Item, id) do
      nil -> conn |> put_status(:not_found) |> json(%{error: "item not found"})
      item ->
        Repo.delete!(item)
        conn |> json(%{success: "item deleted"})
    end
  end
end
