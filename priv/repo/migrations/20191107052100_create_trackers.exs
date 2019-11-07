defmodule Timesheet.Repo.Migrations.CreateTrackers do
  use Ecto.Migration

  def change do
    create table(:trackers) do
      add :date_logged, :date
      add :timesheet_id, :integer

      timestamps()
    end

  end
end
