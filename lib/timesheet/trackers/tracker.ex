defmodule Timesheet.Trackers.Tracker do
  use Ecto.Schema
  import Ecto.Changeset

  schema "trackers" do
    field :date_logged, :date
    field :timesheet_id, :integer

    timestamps()
  end

  @doc false
  def changeset(tracker, attrs) do
    tracker
    |> cast(attrs, [:date_logged, :timesheet_id])
    |> validate_required([:date_logged, :timesheet_id])
  end
end
