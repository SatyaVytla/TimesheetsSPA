defmodule Timesheet.Logsheets.Logsheet do
  use Ecto.Schema
  import Ecto.Changeset

  schema "logsheets" do
    field :approve, :boolean, default: false
    field :date_logged, :date
    field :hours, :integer
    field :task_seqno, :integer

    belongs_to :jobs, Timesheet.Jobs.Job, foreign_key: :job_code, type: :string
    belongs_to :user, Timesheet.Users.User
    timestamps()
  end

  @doc false
  def changeset(logsheet, attrs) do
    logsheet
    |> cast(attrs, [:date_logged, :hours, :task_seqno, :approve, :user_id, :job_code])
    |> validate_inclusion(:hours, 0..8)
    |> validate_required([:date_logged, :hours, :user_id, :job_code])
  end
end
