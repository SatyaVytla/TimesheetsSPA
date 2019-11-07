defmodule Timesheet.Logsheets.Logsheet do
  use Ecto.Schema
  import Ecto.Changeset

  schema "logsheets" do
    field :approve, :boolean, default: false
    field :date_logged, :date
    field :hours, :integer
    field :task_seqno, :integer

    timestamps()
  end

  @doc false
  def changeset(logsheet, attrs) do
    logsheet
    |> cast(attrs, [:date_logged, :hours, :task_seqno, :approve])
    |> validate_required([:date_logged, :hours, :task_seqno, :approve])
  end
end
