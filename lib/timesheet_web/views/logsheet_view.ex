defmodule TimesheetWeb.LogsheetView do
  use TimesheetWeb, :view
  alias TimesheetWeb.LogsheetView

  def render("index.json", %{logsheets: logsheets}) do
    %{data: render_many(logsheets, LogsheetView, "logsheet.json")}
  end

  def render("show.json", %{logsheet: logsheet}) do
    %{data: render_one(logsheet, LogsheetView, "logsheet.json")}
  end

  def render("logsheet.json", %{logsheet: logsheet}) do
    %{id: logsheet.id,
      date_logged: logsheet.date_logged,
      job_code: logsheet.job_code,
      user_id: logsheet.user_id,
      hours: logsheet.hours,
      task_seqno: logsheet.task_seqno,
      approve: logsheet.approve}
  end
end
