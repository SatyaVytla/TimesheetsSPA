defmodule Timesheet.Repo.Migrations.CreateLogsheets do
  use Ecto.Migration

  def change do
    create table(:logsheets) do
      add :date_logged, :date
      add :hours, :integer
      add :task_seqno, :integer
      add :approve, :boolean, default: false, null: false
      add :job_code, references(:jobs, column: :job_code, type: :string)
      add :user_id, references(:users)

      timestamps()
    end

  end
end
