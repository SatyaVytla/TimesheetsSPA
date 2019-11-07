defmodule TimesheetWeb.TrackerView do
  use TimesheetWeb, :view
  alias TimesheetWeb.TrackerView

  def render("index.json", %{trackers: trackers}) do
    %{data: render_many(trackers, TrackerView, "tracker.json")}
  end

  def render("show.json", %{tracker: tracker}) do
    %{data: render_one(tracker, TrackerView, "tracker.json")}
  end

  def render("tracker.json", %{tracker: tracker}) do
    %{id: tracker.id,
      date_logged: tracker.date_logged,
      timesheet_id: tracker.timesheet_id}
  end
end
