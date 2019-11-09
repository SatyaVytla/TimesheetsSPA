defmodule Timesheet.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :ismanager, :boolean, default: false, null: false
      add :password_hash, :string
      add :user_name, :string
      add :manager_id, :integer

      timestamps()
    end

  end
end
