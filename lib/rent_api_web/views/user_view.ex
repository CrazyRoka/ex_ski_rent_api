defmodule RentApiWeb.UserView do
  use RentApiWeb, :view

  def render("show.json", %{user: user}) do
    Poison.encode!(%{"user": user})
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
