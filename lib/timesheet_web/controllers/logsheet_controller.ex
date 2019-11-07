defmodule TimesheetWeb.LogsheetController do
  use TimesheetWeb, :controller

  alias Timesheet.Logsheets
  alias Timesheet.Logsheets.Logsheet

  action_fallback TimesheetWeb.FallbackController

  def index(conn, _params) do
    logsheets = Logsheets.list_logsheets()
    render(conn, "index.json", logsheets: logsheets)
  end

  def create(conn, %{"logsheet" => logsheet_params}) do
    with {:ok, %Logsheet{} = logsheet} <- Logsheets.create_logsheet(logsheet_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.logsheet_path(conn, :show, logsheet))
      |> render("show.json", logsheet: logsheet)
    end
  end

  def show(conn, %{"id" => id}) do
    logsheet = Logsheets.get_logsheet!(id)
    render(conn, "show.json", logsheet: logsheet)
  end

  def update(conn, %{"id" => id, "logsheet" => logsheet_params}) do
    logsheet = Logsheets.get_logsheet!(id)

    with {:ok, %Logsheet{} = logsheet} <- Logsheets.update_logsheet(logsheet, logsheet_params) do
      render(conn, "show.json", logsheet: logsheet)
    end
  end

  def delete(conn, %{"id" => id}) do
    logsheet = Logsheets.get_logsheet!(id)

    with {:ok, %Logsheet{}} <- Logsheets.delete_logsheet(logsheet) do
      send_resp(conn, :no_content, "")
    end
  end
end
