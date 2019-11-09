defmodule Timesheet.Repo.Migrations.CreateJobs do
  use Ecto.Migration

  def change do
    create table(:jobs, primary_key: false) do
      add :job_code, :string, primary_key: true
      add :job_name, :string
      add :supervisor, :integer

      timestamps()
    end

  end
end
