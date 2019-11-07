defmodule TimesheetWeb.UserView do
  use TimesheetWeb, :view
  alias TimesheetWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      ismanager: user.ismanager,
      password_hash: user.password_hash,
      user_name: user.user_name,
      manager_id: user.manager_id,
      password: user.password}
  end
end
