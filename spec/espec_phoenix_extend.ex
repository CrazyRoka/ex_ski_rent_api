defmodule ESpec.Phoenix.Extend do
  def model do
    quote do
      alias RentApi.Repo
    end
  end

  def controller do
    quote do
      alias RentApi
      import RentApi.Router.Helpers

      @endpoint RentApi.Endpoint
    end
  end

  def view do
    quote do
      import RentApi.Router.Helpers
    end
  end

  def channel do
    quote do
      alias RentApi.Repo

      @endpoint RentApi.Endpoint
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
