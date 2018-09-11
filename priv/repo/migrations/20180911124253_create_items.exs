defmodule RentApi.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:rent_items) do
      add :name, :string
      add :daily_price_cents, :integer
      add :owner_id, references(:account_users, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:rent_items, [:owner_id])
  end
end
