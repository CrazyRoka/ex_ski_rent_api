defmodule RentApiWeb.ItemController do
  use RentApiWeb, :controller
  alias RentApi.Repo
  alias RentApi.Rent
  alias RentApi.Rent.Item


  def index(conn, params) do
    page = Item |> Repo.paginate(params)
    render(conn, "index.json", items: page.entries, total_count: page.total_entries)
  end

  def show(conn, %{"id" => id}) do
    case Repo.get(Item, id) do
      nil -> conn |> put_status(:not_found) |> json(%{errors: ["Not found"]})
      item -> render(conn, "show.json", item: item)
    end
  end

  def create(conn, params) do
    case Rent.create_item(params) do
      {:ok, item} -> conn |> put_status(:created) |> render("show.json", item: item)
      {:error, changeset} -> conn |> put_status(:forbidden) |> render("errors.json", changeset: changeset)
    end
  end

  def update(conn, %{"id" => id, "item" => item_params}) do
    item = Rent.get_item(id) |> Repo.preload([:owner])

    case Rent.update_item(item, item_params) do
      {:error, changeset} ->
        conn |> put_status(:forbidden) |> render("errors.json", changeset: changeset)
      {:ok, item} -> render(conn, "show.json", item: item)
    end
  end

  def delete(conn, %{"id" => id}) do
    item = Rent.get_item(id)

    case item.id && Rent.delete_item(item) do
      {:ok, item} -> conn |> json(%{success: "Item deleted"})
      nil -> conn |> put_status(:not_found) |> json(%{error: ["Item not found"]})
    end
  end
end
