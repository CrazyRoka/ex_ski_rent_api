defmodule RentApi.Repo.Migrations.CreateBookings do
  use Ecto.Migration

  def change do
    create table(:rent_bookings) do
      add :start_date, :datetime
      add :end_date, :datetime
      add :cost_cents, :integer, null: false, default: 0
      add :item_id, references(:rent_items, on_delete: :nothing)
      add :renter_id, references(:account_users, on_delete: :nothing)

      timestamps()
    end

    create index(:rent_bookings, [:item_id])
    create index(:rent_bookings, [:renter_id])
  end
end
