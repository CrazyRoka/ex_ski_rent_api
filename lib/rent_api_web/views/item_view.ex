defmodule RentApiWeb.ItemView do

  def render("index.json", %{items: items, total_count: total_count}) do
    Poison.encode!(%{"items": items, "total_count": total_count})
  end

  def render("show.json", %{item: item}) do
    Poison.encode!(%{"item": item})
  end

  def render("errors.json", %{changeset: changeset}) do
    errors = Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
                Enum.reduce(opts, msg, fn {key, value}, acc ->
                  String.replace(acc, "%{#{key}}", to_string(value))
                end)
              end)
    %{errors: errors}
  end
end
