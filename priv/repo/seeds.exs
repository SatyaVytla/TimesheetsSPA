# Script for populating the database. You can run it as:
#
#
#
# Inside the script, you can read and write to any of your
# repositories directly:
# mix run priv/repo/seeds.exs
#     Timesheet.Repo.insert!(%Timesheet.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Timesheet.Repo
alias Timesheet.Users.User

alias Timesheet.Jobs.Job

Repo.insert!(%User{user_name: "supervisor1", password_hash: Argon2.add_hash("password1").password_hash, ismanager: true})
Repo.insert!(%User{user_name: "supervisee1", password_hash: Argon2.add_hash("password2").password_hash, manager_id: 1})
Repo.insert!(%User{user_name: "supervisee2", password_hash: Argon2.add_hash("password3").password_hash, manager_id: 1})
Repo.insert!(%User{user_name: "supervisee3", password_hash: Argon2.add_hash("password4").password_hash, manager_id: 1})
Repo.insert!(%User{user_name: "supervisor2", password_hash: Argon2.add_hash("password5").password_hash, ismanager: true})
Repo.insert!(%User{user_name: "supervisee4", password_hash: Argon2.add_hash("password6").password_hash, manager_id: 5})
Repo.insert!(%User{user_name: "supervisee5", password_hash: Argon2.add_hash("password7").password_hash, manager_id: 5})

Repo.insert!(%Job{job_code: "job1", job_name: "Deploy", supervisor: 1})
Repo.insert!(%Job{job_code: "job2", job_name: "Tool setup", supervisor: 1})

