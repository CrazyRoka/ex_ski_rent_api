defmodule RentApiWeb.SessionView do
  use RentApiWeb, :view

  def render("show.json", %{user: user, jwt: jwt}) do
    %{
      data: render_one(user, RentApiWeb.UserView, "show.json"),
      meta: %{token: jwt}
    }
  end

  def render("delete.json", _) do
    %{ok: true}
  end

  def render("errors.json", %{errors: errors}) do
    %{errors: errors}
  end
end
