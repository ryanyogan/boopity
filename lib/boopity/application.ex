defmodule Boopity.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      BoopityWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Boopity.PubSub},
      # Start the Endpoint (http/https)
      BoopityWeb.Endpoint
      # Start a worker by calling: Boopity.Worker.start_link(arg)
      # {Boopity.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Boopity.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    BoopityWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
