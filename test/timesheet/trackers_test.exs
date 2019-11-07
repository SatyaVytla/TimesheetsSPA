defmodule Timesheet.TrackersTest do
  use Timesheet.DataCase

  alias Timesheet.Trackers

  describe "trackers" do
    alias Timesheet.Trackers.Tracker

    @valid_attrs %{date_logged: ~D[2010-04-17], timesheet_id: 42}
    @update_attrs %{date_logged: ~D[2011-05-18], timesheet_id: 43}
    @invalid_attrs %{date_logged: nil, timesheet_id: nil}

    def tracker_fixture(attrs \\ %{}) do
      {:ok, tracker} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Trackers.create_tracker()

      tracker
    end

    test "list_trackers/0 returns all trackers" do
      tracker = tracker_fixture()
      assert Trackers.list_trackers() == [tracker]
    end

    test "get_tracker!/1 returns the tracker with given id" do
      tracker = tracker_fixture()
      assert Trackers.get_tracker!(tracker.id) == tracker
    end

    test "create_tracker/1 with valid data creates a tracker" do
      assert {:ok, %Tracker{} = tracker} = Trackers.create_tracker(@valid_attrs)
      assert tracker.date_logged == ~D[2010-04-17]
      assert tracker.timesheet_id == 42
    end

    test "create_tracker/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Trackers.create_tracker(@invalid_attrs)
    end

    test "update_tracker/2 with valid data updates the tracker" do
      tracker = tracker_fixture()
      assert {:ok, %Tracker{} = tracker} = Trackers.update_tracker(tracker, @update_attrs)
      assert tracker.date_logged == ~D[2011-05-18]
      assert tracker.timesheet_id == 43
    end

    test "update_tracker/2 with invalid data returns error changeset" do
      tracker = tracker_fixture()
      assert {:error, %Ecto.Changeset{}} = Trackers.update_tracker(tracker, @invalid_attrs)
      assert tracker == Trackers.get_tracker!(tracker.id)
    end

    test "delete_tracker/1 deletes the tracker" do
      tracker = tracker_fixture()
      assert {:ok, %Tracker{}} = Trackers.delete_tracker(tracker)
      assert_raise Ecto.NoResultsError, fn -> Trackers.get_tracker!(tracker.id) end
    end

    test "change_tracker/1 returns a tracker changeset" do
      tracker = tracker_fixture()
      assert %Ecto.Changeset{} = Trackers.change_tracker(tracker)
    end
  end
end
