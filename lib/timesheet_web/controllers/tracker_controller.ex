defmodule TimesheetWeb.TrackerController do
  use TimesheetWeb, :controller

  alias Timesheet.Trackers
  alias Timesheet.Trackers.Tracker

  def index(conn, _params) do
    trackers = Trackers.list_trackers()
    render(conn, "index.html", trackers: trackers)
  end

  def new(conn, _params) do
    changeset = Trackers.change_tracker(%Tracker{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"tracker" => tracker_params}) do
    case Trackers.create_tracker(tracker_params) do
      {:ok, tracker} ->
        conn
        |> put_flash(:info, "Tracker created successfully.")
        |> redirect(to: Routes.tracker_path(conn, :show, tracker))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    tracker = Trackers.get_tracker!(id)
    render(conn, "show.html", tracker: tracker)
  end

  def edit(conn, %{"id" => id}) do
    tracker = Trackers.get_tracker!(id)
    changeset = Trackers.change_tracker(tracker)
    render(conn, "edit.html", tracker: tracker, changeset: changeset)
  end

  def update(conn, %{"id" => id, "tracker" => tracker_params}) do
    tracker = Trackers.get_tracker!(id)

    case Trackers.update_tracker(tracker, tracker_params) do
      {:ok, tracker} ->
        conn
        |> put_flash(:info, "Tracker updated successfully.")
        |> redirect(to: Routes.tracker_path(conn, :show, tracker))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", tracker: tracker, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    tracker = Trackers.get_tracker!(id)
    {:ok, _tracker} = Trackers.delete_tracker(tracker)

    conn
    |> put_flash(:info, "Tracker deleted successfully.")
    |> redirect(to: Routes.tracker_path(conn, :index))
  end
end
