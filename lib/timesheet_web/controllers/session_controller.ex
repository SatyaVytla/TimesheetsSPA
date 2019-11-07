defmodule TimesheetWeb.SessionController do
  use TimesheetWeb, :controller

  action_fallback TimesheetWeb.FallbackController


  def create(conn, %{"user_name" => user_name, "password_hash" => password_hash}) do
    user = Timesheet.Users.authenticate_user(user_name, password_hash)
    if user do
      token = Phoenix.Token.sign(conn, "session", user.id)
      resp = %{token: token, user_id: user.id, user_name: user.name}
      conn
      |> put_resp_header("content-type", "application/json; charset=UTF-8")
      |> send_resp(:created, Jason.encode!(resp))
    else
      resp = %{errors: ["Authentication Failed"]}
      conn
      |> put_resp_header("content-type", "application/json; charset=UTF-8")
      |> send_resp(:unauthorized, Jason.encode!(resp))
    end
  end
end