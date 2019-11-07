defmodule Timesheet.Repo.Migrations.CreateJobs do
  use Ecto.Migration

  def change do
    create table(:jobs) do
      add :job_code, :string
      add :job_name, :string
      add :supervisor, :integer

      timestamps()
    end

  end
end
