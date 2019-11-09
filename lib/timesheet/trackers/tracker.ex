defmodule Timesheet.Trackers.Tracker do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:date_logged, :date, autogenerate: false}
  schema "trackers" do
    field :timesheet_id, :id
    has_many :logsheets, Timesheet.Logsheets.Logsheet

    timestamps()
  end

  @doc false
  def changeset(tracker, attrs) do
    tracker
    |> cast(attrs, [:date_logged, :timesheet_id])
    |> validate_required([:date_logged, :timesheet_id])
  end
end
