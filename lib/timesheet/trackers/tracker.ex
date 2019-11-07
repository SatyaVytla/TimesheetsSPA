defmodule Timesheet.Trackers.Tracker do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:date_logged, :date, autogenerate: false}
  schema "trackers" do
    #field :date_logged, :date
    field :timesheet_id, :id
    has_many :logsheets, Timesheet.Logsheets.Logsheet
    timestamps()
  end

  @doc false
  def changeset(tracker, attrs) do
    tracker
    |> cast(attrs, [:timesheet_id, :date_logged])
    |> validate_required([:timesheet_id, :date_logged])
  end
end
