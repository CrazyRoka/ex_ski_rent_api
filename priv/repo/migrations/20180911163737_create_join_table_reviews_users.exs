defmodule RentApi.Repo.Migrations.CreateJoinTableReviewsUsers do
  use Ecto.Migration

  def change do
    create table(:reviews_users, primary_key: false) do
      add :review_id, references(:rent_reviews, on_delete: :delete_all)
      add :user_id, references(:account_users, on_delete: :delete_all)
    end

    create index(:reviews_users, [:review_id])
    create index(:reviews_users, [:user_id])
  end
end
