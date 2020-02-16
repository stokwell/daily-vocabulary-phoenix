defmodule DailyVocabulary.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :email, :string
      add :provider, :string
      add :token, :string
      add :avatar, :string
      add :first_name, :string
      add :last_name, :string

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
