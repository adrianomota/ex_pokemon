defmodule ExPokemonWeb.SigninController do
  use ExPokemonWeb, :controller

  alias ExPokemonWeb.Auth.Guardian

  action_fallback ExPokemonWeb.FallbackController

  def sign_in(conn, params) do
    with {:ok, token} <- Guardian.authenticate(params) do
      conn
      |> put_status(:ok)
      |> render("sign_in.json", token: token)
    end
  end
end
