defmodule TimesheetWeb.LogsheetController do
  use TimesheetWeb, :controller

  alias Timesheet.Logsheets
  alias Timesheet.Logsheets.Logsheet

  alias Timesheet.Jobs
  alias Timesheet.Jobs.Job

  action_fallback TimesheetWeb.FallbackController

  plug TimesheetWeb.Plugs.RequireAuth when action in [:create, :update, :delete]

  def index(conn, params) do
#    IO.inspect(conn.req_headers[:uid])
#    IO.inspect(params)
    logsheets = Logsheets.list_logsheets()
    render(conn, "index.json", logsheets: logsheets)
  end

  def create(conn, logsheet_params ) do

  #  with {:ok, %Logsheet{} = logsheet} <- Logsheets.create_logsheet(logsheet_params) do
      #References : https://github.com/hemanthnhs/CS5610-WebDev-HW6
      numbers = 1..8
      iterList = Enum.to_list(numbers)
      Enum.map(iterList, fn x ->
        insertMap = %{}
        value1 = logsheet_params["hours#{x}"]
        value2 = logsheet_params["job_code#{x}"]
        if (value1 != "0" and String.length(value2) != 0) do
          insertMap= Map.put(insertMap,"hours", value1)
          insertMap= Map.put(insertMap,"job_code", value2)
          insertMap= Map.put(insertMap,"user_id", conn.assigns[:current_user].id)
          date= logsheet_params["date_logged"]
#          split_date = String.split(date, "-")
#          IO.inspect(split_date)
#          {year, ""} = Integer.parse(date["year"])
#          {month, ""} = Integer.parse(date["month"])
#          {day, ""} = Integer.parse(date["day"])
          date_creation = Date.from_iso8601(date)#Date.new(year,month,day)
          {ok,date_logged} = date_creation
          insertMap= Map.put(insertMap,"date_logged", date_logged)
          resp = Logsheets.create_logsheet(insertMap)
        end

      end)
      logsheets = Logsheets.list_logsheets()
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.logsheet_path(conn, :index))
      |> render("index.json", logsheets: logsheets)
    end


  def show(conn, %{"id" => id} ) do
    logsheet = Logsheets.get_logsheet!(id)
    render(conn, "show.json", logsheet: logsheet)
  end

  def update(conn, %{"id" => id, "logsheet" => logsheet_params}) do
    logsheet = Logsheets.get_logsheet!(id)

    with {:ok, %Logsheet{} = logsheet} <- Logsheets.update_logsheet(logsheet, logsheet_params) do
      render(conn, "show.json", logsheet: logsheet)
    end
  end

  def update_task(conn, params) do
    IO.puts("updste")
    IO.inspect(params)
    sheet_id = params["sheet"]
    Logsheets.updateApproveStatus(sheet_id)
    logsheets = Logsheets.list_logsheets()
    conn
    |> put_status(:created)
    |> put_resp_header("location", Routes.logsheet_path(conn, :index))
    |> render("index.json", logsheets: logsheets)
#    redirect(conn, to: Routes.logsheet_path(conn, :index))
  end

  def delete(conn, %{"id" => id}) do
    logsheet = Logsheets.get_logsheet!(id)

    with {:ok, %Logsheet{}} <- Logsheets.delete_logsheet(logsheet) do
      send_resp(conn, :no_content, "")
    end
  end
end
