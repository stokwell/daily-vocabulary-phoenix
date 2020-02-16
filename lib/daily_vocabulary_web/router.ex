defmodule DailyVocabularyWeb.Router do
  use DailyVocabularyWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    # plug DailyVocabularyWeb.Plugs.SetUser
  end

  pipeline :api do
    plug :accepts, ["json"]
    post "/login", AuthController, :login
  end

  scope "/", DailyVocabularyWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/auth", DailyVocabularyWeb do
    pipe_through :browser

    get("/:provider", AuthController, :request)
    get("/:provider/callback", AuthController, :callback)
    post("/:provider/callback", AuthController, :callback)
    delete("/logout", AuthController, :delete)
  end

  # Other scopes may use custom stacks.
  # scope "/api", DailyVocabularyWeb do
  #   pipe_through :api
  # end
end
