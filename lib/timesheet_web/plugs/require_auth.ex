defmodule TimesheetWeb.Plugs.RequireAuth do
  import Plug.Conn
  alias Timesheet.Users
  def init(args), do: args

  def call(conn, _args) do
    IO.puts("here")
    IO.inspect(conn)

    token = List.first(get_req_header(conn, "x-auth"))
    IO.inspect(conn)
    case Phoenix.Token.verify(TimesheetWeb.Endpoint, "session", token, max_age: 86400) do
      {:ok, user_id} ->
        assign(conn, :current_user, Timesheet.Users.get_user!(user_id))
      {:error, err} ->
        conn
        |> put_resp_header("content-type", "application/json; charset=UTF-8")
        |> send_resp(:unprocessable_entity, Jason.encode!(%{"error" => err}))
        |> halt()
    end
  end
end