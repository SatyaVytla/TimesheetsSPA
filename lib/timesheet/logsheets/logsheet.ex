defmodule Timesheet.Logsheets.Logsheet do
  use Ecto.Schema
  import Ecto.Changeset

  schema "logsheets" do
    field :date_logged, :date
    field :hours, :integer
    field :task_seqno, :integer
    field :approve, :boolean

    belongs_to :jobs, Timesheet.Jobs.Job, foreign_key: :job_code, type: :string
    belongs_to :user, Timesheet.Users.User
    timestamps()
  end

  @doc false
  def changeset(logsheet, attrs) do
    logsheet
    |> cast(attrs, [:date_logged, :task_seqno, :hours, :user_id, :job_code, :approve])
    |> validate_inclusion(:hours, 0..8)
    |> validate_required([:date_logged, :hours, :user_id, :job_code])
  end
end
