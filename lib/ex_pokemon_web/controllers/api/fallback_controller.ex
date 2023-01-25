defmodule ExPokemonWeb.FallbackController do
  use ExPokemonWeb, :controller

  def call(conn, {:not_found, result}) do
    conn
    |> put_status(:not_found)
    |> put_view(ExPokemonWeb.ErrorView)
    |> render("404.json", result: result)
  end

  def call(conn, {:unauthorized, result}) do
    conn
    |> put_status(:unauthorized)
    |> put_view(ExPokemonWeb.ErrorView)
    |> render("401.json", result: result)
  end

  def call(conn, {:error, result}) do
    conn
    |> put_status(:bad_request)
    |> put_view(ExPokemonWeb.ErrorView)
    |> render("400.json", result: result)
  end
end
