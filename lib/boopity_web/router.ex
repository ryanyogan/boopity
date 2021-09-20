defmodule BoopityWeb.Router do
  use BoopityWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {BoopityWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BoopityWeb do
    pipe_through :browser

    live "/", PageLive
    live "/pets", PetsLive
    live "/medications", MedicationsLive
  end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: BoopityWeb.Telemetry
    end
  end
end
