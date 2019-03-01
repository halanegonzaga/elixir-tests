defmodule ExampleApp.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do

    create table :users do
      add :username, :string, unique: true
      add :password, :string, null: false
      add :email, :string
      add :confirmed, :boolean, default: false

      timestamps()
    end

  end
end
