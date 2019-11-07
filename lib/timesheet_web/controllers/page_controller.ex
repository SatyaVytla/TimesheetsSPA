defmodule TimesheetWeb.PageController do
  use TimesheetWeb, :controller

  alias Timesheet.Users
  alias Timesheet.Users.User

  def index(conn, params) do
    if( not is_nil(conn.assigns[:current_user])) do
      if(conn.assigns[:current_user].ismanager == true) do
        manager_id = conn.assigns[:current_user].id
        users = Users.get_usernames(manager_id)
        render(conn, "index.html", users: users)

      else
        #worker
        render(conn, "index.html")
      end
    else
      render(conn, "index.html")
    end
  end

  def user_pages(conn, params) do
      if(conn.assigns[:current_user].ismanager == true) do
        user = Users.get_user_by_name(params["user"])
        conn
        |> redirect(to: Routes.logsheet_path(conn, :index, user: user.id))
      else
        #worker
        conn
        |> redirect(to: Routes.logsheet_path(conn, :new, date_selected: conn.params["date_selected"]))
      end
  end

end


