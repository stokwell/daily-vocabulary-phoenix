defmodule DailyVocabularyWeb.AuthController do
  use DailyVocabularyWeb, :controller
  alias DailyVocabulary.{Accounts.User}

  plug Ueberauth

  alias DailyVocabulary.Accounts.UserFromAuth

  alias Ueberauth.Strategy.Helpers

  def request(conn, _params) do
    render(conn, "request.html", callback_url: Helpers.callback_url(conn))
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "You have been logged out!")
    |> clear_session()
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_flash(:error, "Failed to authenticate.")
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
  # def callback(conn, _params) do
    IO.inspect(conn)
    case UserFromAuth.find_or_create(auth) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Successfully authenticated.")
        |> put_session(:current_user, user)
        |> configure_session(renew: true)
        |> redirect(to: "/")

      {:error, reason} ->
        conn
        |> put_flash(:error, reason)
        |> redirect(to: "/")
    end
  end

  def signout(conn, _params) do
        conn
        |> configure_session(drop: true)
        |> redirect(to: page_path(conn, :index))
  end
end
