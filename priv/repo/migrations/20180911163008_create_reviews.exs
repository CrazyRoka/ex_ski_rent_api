defmodule RentApi.Repo.Migrations.CreateReviews do
  use Ecto.Migration

  def change do
    create table(:rent_reviews) do
      add :description, :text
      add :author_id, references(:account_users, on_delete: :nothing)
      add :item_id, references(:rent_items, on_delete: :delete_all), null: true
      add :user_id, references(:account_users, on_delete: :delete_all), null: true

      timestamps()
    end

    create index(:rent_reviews, [:author_id, :item_id, :user_id])
  end
end
