defmodule LiveupWeb.Router do
  use LiveupWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {LiveupWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LiveupWeb do
    pipe_through :browser

    get "/", PageController, :home
    live "/scene/:scene_id", SceneLive.CurrentUpcoming, :index
  end

  scope "/admin", LiveupWeb do
    pipe_through :browser

    get "/", PageController, :admin

    live "/events", EventLive.Index, :index
    live "/events/new", EventLive.Index, :new
    live "/events/:id/edit", EventLive.Index, :edit
    live "/events/:id", EventLive.Show, :show
    live "/events/:id/show/edit", EventLive.Show, :edit

    live "/scenes", SceneLive.Index, :index
    live "/scenes/new", SceneLive.Index, :new
    live "/scenes/:id/edit", SceneLive.Index, :edit
    live "/scenes/:id", SceneLive.Show, :show
    live "/scenes/:id/show/edit", SceneLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", LiveupWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:liveup, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: LiveupWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
