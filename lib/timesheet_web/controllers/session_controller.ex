defmodule TimesheetWeb.SessionController do
  use TimesheetWeb, :controller

  action_fallback TimesheetWeb.FallbackController


  def create(conn, %{"email" => user_name, "password" => password_hash}) do
    IO.puts(user_name)
    user = Timesheet.Users.authenticate_user(user_name, password_hash)
    if user do

      token = Phoenix.Token.sign(conn, "session", user.id)
      resp = %{token: token, manager: user.ismanager, user_id: user.id, user_name: user.user_name}
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