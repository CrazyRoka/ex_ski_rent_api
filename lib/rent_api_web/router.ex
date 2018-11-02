defmodule RentApiWeb.Router do
  use RentApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", RentApiWeb do
    pipe_through :api

    resources "/items", ItemController, only: [:index, :show, :update, :delete, :create]
  end
end
