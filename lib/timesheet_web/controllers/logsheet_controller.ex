defmodule TimesheetWeb.LogsheetController do
  use TimesheetWeb, :controller

  alias Timesheet.Logsheets
  alias Timesheet.Logsheets.Logsheet

  alias Timesheet.Jobs
  alias Timesheet.Jobs.Job

  def index(conn, params) do
    #logsheets = Logsheets.list_logsheets()
    logsheets = Logsheets.get_workerlogs(params["user"])
    render(conn, "index.html", logsheets: logsheets, user_id: params["user"])
  end

  def new(conn, params) do
    changeset = Logsheets.change_logsheet(%Logsheet{})
    jobs = Jobs.get_jobcodes()
    date= params["date_selected"]
    {year, ""} = Integer.parse(date["year"])
    {month, ""} = Integer.parse(date["month"])
    {day, ""} = Integer.parse(date["day"])
    date_creation = Date.new(year,month,day)
    {ok,date_logged} = date_creation
    render(conn, "new.html", changeset: changeset, jobs: jobs, date_logged: date_logged)
  end

  def create(conn, %{"logsheet" => logsheet_params}) do
    IO.puts("con")
    IO.inspect(conn)
    #References : https://github.com/hemanthnhs/CS5610-WebDev-HW6
    numbers = 1..8
    iterList = Enum.to_list(numbers)
    Enum.map(iterList, fn x ->
      insertMap = %{}
      value1 = logsheet_params[":hours#{x}"]
      if (String.length(value1) != 0) do
        value2 = logsheet_params[":job#{x}"]
        insertMap= Map.put(insertMap,"hours", value1)
        insertMap= Map.put(insertMap,"job_code", value2)
        insertMap= Map.put(insertMap,"user_id", conn.assigns[:current_user].id)
        date= logsheet_params["date_logged"]
        {year, ""} = Integer.parse(date["year"])
        {month, ""} = Integer.parse(date["month"])
        {day, ""} = Integer.parse(date["day"])
        date_creation = Date.new(year,month,day)
        {ok,date_logged} = date_creation
        insertMap= Map.put(insertMap,"date_logged", date_logged)
        resp = Logsheets.create_logsheet(insertMap)
        IO.inspect(resp)
      end
    end)
      conn
      |> put_flash(:info, "Logsheet created successfully.")
#      |> redirect(to: Routes.logsheet_path(conn, :show, "#{conn.assigns[:current_user].id}_#{logsheet_params["date_logged"]["day"]}_#{logsheet_params["date_logged"]["month"]}_#{logsheet_params["date_logged"]["year"]}"))
      |> redirect(to: Routes.logsheet_path(conn, :show, "ff", %{:user_id => conn.assigns[:current_user].id, :date => logsheet_params["date_logged"]}))
  end

  def show(conn, params) do
   # logsheet = Logsheets.get_logsheet!(id)
    IO.puts("show")
    IO.inspect(params)
    user_id = params["user_id"]
    date= params["date"]
    {year, ""} = Integer.parse(date["year"])
    {month, ""} = Integer.parse(date["month"])
    {day, ""} = Integer.parse(date["day"])
    date_creation = Date.new(year,month,day)
    {ok,date} = date_creation
    logs = Logsheets.get_userlogs(user_id,date)
    approve_status = Logsheets.get_status(user_id,date)
    IO.inspect(approve_status)
   render(conn, "show.html", date: date, user_id: user_id, logs: logs, approve_status: approve_status)
  end

  def edit(conn, params) do
    #logsheet = Logsheets.get_logsheet!(id)
    #changeset = Logsheets.change_logsheet(logsheet)
    user_id = params["user_id"]
    date= params["date"]
    logsheets = Logsheets.updateApproveStatus(user_id,date)
    render(conn, "index.html", logsheets: logsheets, user_id: user_id)
  end

  def update_task(conn, params) do
    IO.puts("updste")
    user_id = params["user_id"]
    date= params["date"]
    Logsheets.updateApproveStatus(user_id,date)
    redirect(conn, to: Routes.logsheet_path(conn, :index, user: user_id))
  end

  def delete(conn, %{"id" => id}) do
    logsheet = Logsheets.get_logsheet!(id)
    {:ok, _logsheet} = Logsheets.delete_logsheet(logsheet)

    conn
    |> put_flash(:info, "Logsheet deleted successfully.")
    |> redirect(to: Routes.logsheet_path(conn, :index))
  end
end
