# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :test_app,
  ecto_repos: [TestApp.Repo]

# Configures the endpoint
config :test_app, TestAppWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "sTR2coFiOjZmX/FZmzXs6remNJWEY/CDHx3Ffze0UB1h5fal7HL8hq/MvUdPFCbv",
  render_errors: [view: TestAppWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: TestApp.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :guardian, Guardian,
  issuer: "TestApp.#{Mix.env}",
  ttl: {30, :days},
  verify_issuer: true,
  serializer: TestApp.GuardianSerializer,
  secret_key: to_string(Mix.env) <> "SuPerseCret_aBraCadabrA"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
