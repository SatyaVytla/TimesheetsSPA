defmodule Timesheet.Jobs.Job do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:job_code, :string, autogenerate: false}
  schema "jobs" do
    field :job_name, :string
    field :supervisor, :integer

    has_many :logsheets, Timesheet.Logsheets.Logsheet

    timestamps()
  end

  @doc false
  def changeset(job, attrs) do
    job
    |> cast(attrs, [:job_code, :job_name, :supervisor])
    |> validate_required([:job_code, :job_name, :supervisor])
  end
end
