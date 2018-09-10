defmodule RentApi.Repo.Migrations.CreateAccountUsers do
  use Ecto.Migration

  def change do
    create table(:account_users) do
      add :name, :string
      add :password_digest, :string
      add :email, :string
      add :balance, :integer

      timestamps()
    end

    create unique_index :account_users, :email, unique: true
  end
end
