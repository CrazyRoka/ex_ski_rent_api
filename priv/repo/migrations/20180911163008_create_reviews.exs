defmodule RentApi.Repo.Migrations.CreateReviews do
  use Ecto.Migration

  def change do
    create table(:rent_reviews) do
      add :description, :text
      add :author_id, references(:account_users, on_delete: :nothing)

      timestamps()
    end

    create index(:rent_reviews, [:author_id])
  end
end
