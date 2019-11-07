defmodule Timesheet.LogsheetsTest do
  use Timesheet.DataCase

  alias Timesheet.Logsheets

  describe "logsheets" do
    alias Timesheet.Logsheets.Logsheet

    @valid_attrs %{date_logged: ~D[2010-04-17], hours: 42, jobcode: "some jobcode", task_seqno: 42, user_id: 42}
    @update_attrs %{date_logged: ~D[2011-05-18], hours: 43, jobcode: "some updated jobcode", task_seqno: 43, user_id: 43}
    @invalid_attrs %{date_logged: nil, hours: nil, jobcode: nil, task_seqno: nil, user_id: nil}

    def logsheet_fixture(attrs \\ %{}) do
      {:ok, logsheet} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Logsheets.create_logsheet()

      logsheet
    end

    test "list_logsheets/0 returns all logsheets" do
      logsheet = logsheet_fixture()
      assert Logsheets.list_logsheets() == [logsheet]
    end

    test "get_logsheet!/1 returns the logsheet with given id" do
      logsheet = logsheet_fixture()
      assert Logsheets.get_logsheet!(logsheet.id) == logsheet
    end

    test "create_logsheet/1 with valid data creates a logsheet" do
      assert {:ok, %Logsheet{} = logsheet} = Logsheets.create_logsheet(@valid_attrs)
      assert logsheet.date_logged == ~D[2010-04-17]
      assert logsheet.hours == 42
      assert logsheet.jobcode == "some jobcode"
      assert logsheet.task_seqno == 42
      assert logsheet.user_id == 42
    end

    test "create_logsheet/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Logsheets.create_logsheet(@invalid_attrs)
    end

    test "update_logsheet/2 with valid data updates the logsheet" do
      logsheet = logsheet_fixture()
      assert {:ok, %Logsheet{} = logsheet} = Logsheets.update_logsheet(logsheet, @update_attrs)
      assert logsheet.date_logged == ~D[2011-05-18]
      assert logsheet.hours == 43
      assert logsheet.jobcode == "some updated jobcode"
      assert logsheet.task_seqno == 43
      assert logsheet.user_id == 43
    end

    test "update_logsheet/2 with invalid data returns error changeset" do
      logsheet = logsheet_fixture()
      assert {:error, %Ecto.Changeset{}} = Logsheets.update_logsheet(logsheet, @invalid_attrs)
      assert logsheet == Logsheets.get_logsheet!(logsheet.id)
    end

    test "delete_logsheet/1 deletes the logsheet" do
      logsheet = logsheet_fixture()
      assert {:ok, %Logsheet{}} = Logsheets.delete_logsheet(logsheet)
      assert_raise Ecto.NoResultsError, fn -> Logsheets.get_logsheet!(logsheet.id) end
    end

    test "change_logsheet/1 returns a logsheet changeset" do
      logsheet = logsheet_fixture()
      assert %Ecto.Changeset{} = Logsheets.change_logsheet(logsheet)
    end
  end
end
