defmodule TimesheetWeb.JobView do
  use TimesheetWeb, :view
  alias TimesheetWeb.JobView

  def render("index.json", %{jobs: jobs}) do
    %{data: render_many(jobs, JobView, "job.json")}
  end

  def render("show.json", %{job: job}) do
    %{data: render_one(job, JobView, "job.json")}
  end

  def render("job.json", %{job: job}) do
    %{id: job.id,
      job_code: job.job_code,
      job_name: job.job_name,
      supervisor: job.supervisor}
  end
end
