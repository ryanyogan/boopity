use Mix.Config

config :boopity, BoopityWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "XC2TiZHZm8SvyeEU2DzohHXS/gbpTE3WbUdTTs4vNf92aSiMLZG1CyVR5pUQBpYn",
  render_errors: [view: BoopityWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Boopity.PubSub,
  live_view: [signing_salt: "v4gSdXtb"]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

config :tesla, adapter: Tesla.Adapter.Hackney

config :boopity, Boopity.Repo, adapter: Boopity.Repo.Http

import_config "#{Mix.env()}.exs"
