defmodule Timesheet.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :ismanager, :boolean, default: false
    field :password_hash, :string
    field :user_name, :string
    field :manager_id, :integer

    #belongs_to :logsheets, Timesheet.Logsheets.Logsheet
    has_many :logsheets, Timesheet.Logsheets.Logsheet

    field :password, :string, virtual: true
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:user_name, :password_hash, :ismanager, :manager_id])
    |> validate_length(:password_hash, min: 8)
    |> hash_password()
    |> validate_required([:user_name, :password_hash, :ismanager, :manager_id])
  end

  def hash_password(cset) do
    pw = get_change(cset, :password)
    if pw do
      change(cset, Argon2.add_hash(pw))
    else
      cset
    end
  end
end
