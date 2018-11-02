defmodule RentApi.Rent do
  alias RentApi.Rent.Item
  alias RentApi.Repo

  def create_item(params) do
    Item.changeset(%Item{}, params)
    |> Repo.insert()
  end

  def delete_item(item = %Item{}) do
    Repo.delete(item)
  end

  def update_item(item = %Item{}, params) do
    item
    |> Item.changeset(params)
    |> Repo.update()
  end

  def new_item do
    Item.changeset(%Item{}, %{})
  end

  def get_item(id) do
    Repo.get(Item, id) || %Item{}
  end
end
