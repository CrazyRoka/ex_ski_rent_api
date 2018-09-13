defmodule RentApi.Repo.Migrations.CreateCities do
  use Ecto.Migration

  def change do
    create table(:rent_cities) do
      add :name, :string

      timestamps()
    end

  end
end
