defmodule Timesheet.Jobs.Job do
  use Ecto.Schema
  import Ecto.Changeset

  schema "jobs" do
    field :job_code, :string
    field :job_name, :string
    field :supervisor, :integer

    timestamps()
  end

  @doc false
  def changeset(job, attrs) do
    job
    |> cast(attrs, [:job_code, :job_name, :supervisor])
    |> validate_required([:job_code, :job_name, :supervisor])
  end
end
