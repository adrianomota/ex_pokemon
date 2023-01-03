defmodule ExPokemonWeb.PokemonController do
  use ExPokemonWeb, :controller

  action_fallback ExPokemonWeb.FallbackController

  def show(conn, %{"name" => name} = _params) do
    name
    |> ExPokemon.fetch_pokemon()
    |> handle_response(conn)
  end

  defp handle_response({:ok, pokemon}, conn) do
    conn
    |> put_status(:ok)
    |> json(pokemon)
  end

  defp handle_response({message, 404}, conn) do
    conn
    |> put_status(:not_found)
    |> render("404.json", result: message)
  end

  defp handle_response({:error, _reason} = error, _conn), do: error
end
