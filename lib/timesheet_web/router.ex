defmodule TimesheetWeb.Router do
  use TimesheetWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :ajax do
    plug :accepts, ["json"]
    plug :fetch_session
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/ajax", TimesheetWeb do
    pipe_through :ajax

    get "/", PageController, :index
    post "/user_pages", PageController, :user_pages
    post "/update_task", LogsheetController, :update_task

    resources "/users", UserController
    resources "/jobs", JobController, except: [:new, :edit]
    resources "/trackers", TrackerController
    resources "/logsheets", LogsheetController, except: [:new, :edit]
    resources "/session", SessionController, only: [:create], singleton: true
  end

   scope "/", TimesheetWeb do
     pipe_through :browser

     get "/", PageController, :index
     get "/users", PageController, :index
     get "/*path", PageController, :index

  end

  # Other scopes may use custom stacks.
  # scope "/api", TimesheetWeb do
  #   pipe_through :api
  # end
end
