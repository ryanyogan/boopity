# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :boopity, BoopityWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "XC2TiZHZm8SvyeEU2DzohHXS/gbpTE3WbUdTTs4vNf92aSiMLZG1CyVR5pUQBpYn",
  render_errors: [view: BoopityWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Boopity.PubSub,
  live_view: [signing_salt: "v4gSdXtb"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
