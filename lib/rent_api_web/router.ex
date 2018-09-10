defmodule RentApiWeb.Router do
  use RentApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", RentApiWeb do
    pipe_through :api
  end
end
