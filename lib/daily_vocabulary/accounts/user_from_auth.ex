defmodule DailyVocabulary.Accounts.UserFromAuth do
  @moduledoc """
  Retrieve the user information from an auth request
  """
  require Logger
  require Poison

  alias Ueberauth.Auth

  def find_or_create(%Auth{} = auth) do
    IO.puts("AUTH>INFO")
    IO.inspect(auth.info.email)
    {:ok, basic_info(auth)}
  end

  defp basic_info(auth) do
    %{id: auth.uid, email: email_from_auth(auth)}
  end

  defp email_from_auth(auth) do
    if auth.info.email do
      auth.info.email
    else
      "XXXX@XXXX.com"
    end
  end

  defp name_from_auth(auth) do
  if auth.info.name do
    auth.info.name
  else
    name =
      [auth.info.first_name, auth.info.last_name]
      |> Enum.filter(&(&1 != nil and &1 != ""))

    if Enum.empty?(name) do
      auth.info.nickname
    else
      Enum.join(name, " ")
    end
  end
end
end
