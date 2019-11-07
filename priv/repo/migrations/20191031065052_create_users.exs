defmodule Timesheet.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :user_name, :string
      add :password_hash, :string
      add :ismanager, :boolean, default: false, null: false
      add :manager_id, :integer

      timestamps()
    end


  end
end
