defmodule TimesheetWeb.LogsheetControllerTest do
  use TimesheetWeb.ConnCase

  alias Timesheet.Logsheets
  alias Timesheet.Logsheets.Logsheet

  @create_attrs %{
    approve: true,
    date_logged: ~D[2010-04-17],
    hours: 42,
    task_seqno: 42
  }
  @update_attrs %{
    approve: false,
    date_logged: ~D[2011-05-18],
    hours: 43,
    task_seqno: 43
  }
  @invalid_attrs %{approve: nil, date_logged: nil, hours: nil, task_seqno: nil}

  def fixture(:logsheet) do
    {:ok, logsheet} = Logsheets.create_logsheet(@create_attrs)
    logsheet
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all logsheets", %{conn: conn} do
      conn = get(conn, Routes.logsheet_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create logsheet" do
    test "renders logsheet when data is valid", %{conn: conn} do
      conn = post(conn, Routes.logsheet_path(conn, :create), logsheet: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.logsheet_path(conn, :show, id))

      assert %{
               "id" => id,
               "approve" => true,
               "date_logged" => "2010-04-17",
               "hours" => 42,
               "task_seqno" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.logsheet_path(conn, :create), logsheet: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update logsheet" do
    setup [:create_logsheet]

    test "renders logsheet when data is valid", %{conn: conn, logsheet: %Logsheet{id: id} = logsheet} do
      conn = put(conn, Routes.logsheet_path(conn, :update, logsheet), logsheet: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.logsheet_path(conn, :show, id))

      assert %{
               "id" => id,
               "approve" => false,
               "date_logged" => "2011-05-18",
               "hours" => 43,
               "task_seqno" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, logsheet: logsheet} do
      conn = put(conn, Routes.logsheet_path(conn, :update, logsheet), logsheet: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete logsheet" do
    setup [:create_logsheet]

    test "deletes chosen logsheet", %{conn: conn, logsheet: logsheet} do
      conn = delete(conn, Routes.logsheet_path(conn, :delete, logsheet))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.logsheet_path(conn, :show, logsheet))
      end
    end
  end

  defp create_logsheet(_) do
    logsheet = fixture(:logsheet)
    {:ok, logsheet: logsheet}
  end
end
