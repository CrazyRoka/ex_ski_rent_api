defmodule RentApi.Repo.Migrations.AddCityIdToUser do
  use Ecto.Migration

  def change do
    alter table(:account_users) do
      add :city_id, references(:rent_cities, on_delete: :nothing), null: true
    end

    create index(:account_users, [:city_id])
  end
end
