defmodule RentApiWeb.ItemView do
  def render("index.json", %{items: items, total_count: total_count}) do
    Poison.encode!(%{"items": items, "total_count": total_count})
  end

  def render("show.json", %{item: item}) do
    Poison.encode!(%{"item": item})
  end
end
