defmodule TimesheetWeb.LogsheetControllerTest do
  use TimesheetWeb.ConnCase

  alias Timesheet.Logsheets

  @create_attrs %{date_logged: ~D[2010-04-17], hours: 42, jobcode: "some jobcode", task_seqno: 42, user_id: 42}
  @update_attrs %{date_logged: ~D[2011-05-18], hours: 43, jobcode: "some updated jobcode", task_seqno: 43, user_id: 43}
  @invalid_attrs %{date_logged: nil, hours: nil, jobcode: nil, task_seqno: nil, user_id: nil}

  def fixture(:logsheet) do
    {:ok, logsheet} = Logsheets.create_logsheet(@create_attrs)
    logsheet
  end

  describe "index" do
    test "lists all logsheets", %{conn: conn} do
      conn = get(conn, Routes.logsheet_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Logsheets"
    end
  end

  describe "new logsheet" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.logsheet_path(conn, :new))
      assert html_response(conn, 200) =~ "New Logsheet"
    end
  end

  describe "create logsheet" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.logsheet_path(conn, :create), logsheet: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.logsheet_path(conn, :show, id)

      conn = get(conn, Routes.logsheet_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Logsheet"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.logsheet_path(conn, :create), logsheet: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Logsheet"
    end
  end

  describe "edit logsheet" do
    setup [:create_logsheet]

    test "renders form for editing chosen logsheet", %{conn: conn, logsheet: logsheet} do
      conn = get(conn, Routes.logsheet_path(conn, :edit, logsheet))
      assert html_response(conn, 200) =~ "Edit Logsheet"
    end
  end

  describe "update logsheet" do
    setup [:create_logsheet]

    test "redirects when data is valid", %{conn: conn, logsheet: logsheet} do
      conn = put(conn, Routes.logsheet_path(conn, :update, logsheet), logsheet: @update_attrs)
      assert redirected_to(conn) == Routes.logsheet_path(conn, :show, logsheet)

      conn = get(conn, Routes.logsheet_path(conn, :show, logsheet))
      assert html_response(conn, 200) =~ "some updated jobcode"
    end

    test "renders errors when data is invalid", %{conn: conn, logsheet: logsheet} do
      conn = put(conn, Routes.logsheet_path(conn, :update, logsheet), logsheet: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Logsheet"
    end
  end

  describe "delete logsheet" do
    setup [:create_logsheet]

    test "deletes chosen logsheet", %{conn: conn, logsheet: logsheet} do
      conn = delete(conn, Routes.logsheet_path(conn, :delete, logsheet))
      assert redirected_to(conn) == Routes.logsheet_path(conn, :index)
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
