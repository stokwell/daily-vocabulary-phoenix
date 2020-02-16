# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config
config :phoenix, :json_library, Poison

# General application configuration
config :daily_vocabulary,
  ecto_repos: [DailyVocabulary.Repo]

# Configures the endpoint
config :daily_vocabulary, DailyVocabularyWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "TYcybL/XgyVtc8kobnUKsMMYMvAdoiTkgfaKzMf+rqWDDXdcMPOvWuGZn+X0njxc",
  render_errors: [view: DailyVocabularyWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: DailyVocabulary.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]


# Configures Ueberauth providers
config :ueberauth, Ueberauth,
  providers: [
    vkontakte: { Ueberauth.Strategy.VK, []},
    facebook: {Ueberauth.Strategy.Facebook, [
      default_scope: "email,public_profile,user_friends",
    ]},
    google: {Ueberauth.Strategy.Google, [default_scope: "email profile"]}
  ]

config :ueberauth, Ueberauth.Strategy.VK.OAuth,
  client_id: System.get_env("VK_CLIENT_ID",
  client_secret: System.get_env("VK_CLIENT_SECRET")"",
  access_token: System.get_env("VK_ACCESS_TOKEN")

config :ueberauth, Ueberauth.Strategy.Facebook.OAuth,
  client_id: System.get_env("FACEBOOK_CLIENT_ID"),
  client_secret: System.get_env("FACEBOOK_CLIENT_SECRET"),
  redirect_uri: System.get_env("FACEBOOK_REDIRECT_URI")

config :ueberauth, Ueberauth.Strategy.Google.OAuth,
  client_id: System.get_env("GOOGLE_CLIENT_ID"),
  client_secret: System.get_env("GOOGLE_CLIENT_SECRET")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
