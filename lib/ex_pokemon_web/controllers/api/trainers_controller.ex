defmodule ExPokemonWeb.TrainersController do
  use ExPokemonWeb, :controller

  action_fallback(ExPokemonWeb.FallbackController)

  def create(conn, params) do
    params
    |> ExPokemon.create_trainer()
    |> handle_response(conn)
  end

  defp handle_response({:ok, trainer}, conn) do
    conn
    |> put_status(:created)
    |> render("create.json", trainer: trainer)
  end

  defp handle_response({:error, _changeset} = error, _conn), do: error
end
