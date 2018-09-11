defmodule RentApi.Repo.Migrations.CreateJoinTableReviewsItems do
  use Ecto.Migration

  def change do
    create table(:reviews_items, primary_key: false) do
      add :review_id, references(:rent_reviews, on_delete: :delete_all)
      add :item_id, references(:rent_items, on_delete: :delete_all)
    end

    create index(:reviews_items, [:review_id])
    create index(:reviews_items, [:item_id])
  end
end
