defmodule Timesheet.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :ismanager, :boolean, default: false
    field :manager_id, :integer
    field :password, :string
    field :password_hash, :string
    field :user_name, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:ismanager, :password_hash, :user_name, :manager_id, :password])
    |> validate_required([:ismanager, :password_hash, :user_name, :manager_id, :password])
  end
end
