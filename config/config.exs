# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :phoenix_cms,
  ecto_repos: [PhoenixCms.Repo]

# Configures the endpoint
config :phoenix_cms, PhoenixCmsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "MppJqeRM9cQ9nTrj4uaj/erG/5fTtk8VzxdKRprECHBx6iG7ZZmvBAzZNLP0jsRK",
  render_errors: [view: PhoenixCmsWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: PhoenixCms.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
