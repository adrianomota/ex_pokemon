defmodule ExPokemonWeb.FallbackController do
  use ExPokemonWeb, :controller

  def call(conn, {:error, result}) do
    conn
    |> put_status(:bad_request)
    |> put_view(ExPokemonWeb.ErrorView)
    |> render("400.json", result: result)
  end
end
