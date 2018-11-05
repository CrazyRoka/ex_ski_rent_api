defmodule RentApiWeb.Router do
  use RentApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :api_auth do
    plug(RentApi.Auth.Pipeline)
  end

  scope "/api", RentApiWeb do
    pipe_through :api

    resources "/items", ItemController, only: [:index, :show, :update, :delete, :create]
    resources "/users", UserController, only: [:create]
    resources "/sessions", SessionController, only: [:create]
  end

  scope "/api", RentApiWeb do
    pipe_through [:api, :api_auth]

    resources "/sessions", SessionController, only: [:delete, :refresh]
  end
end
