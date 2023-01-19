defmodule ExPokemonWeb.TrainerPokemonsController do
  use ExPokemonWeb, :controller

  action_fallback ExPokemonWeb.FallbackController

  def index(conn, params) do
    ExPokemon.paginate_trainers_pokemons(params)
    |> handle_index_response(conn, "index.json", :ok)
  end

  def create(conn, params) do
    params
    |> ExPokemon.create_trainer_pokemon()
    |> handle_response(conn, "create.json", :created)
  end

  def show(conn, %{"id" => id}) do
    id
    |> ExPokemon.fetch_trainer_pokemon()
    |> handle_response(conn, "show.json", :ok)
  end

  def delete(conn, %{"id" => id}) do
    id
    |> ExPokemon.delete_trainer_pokemon()
    |> IO.inspect()
    |> handle_delete_response(conn)
  end

  defp handle_delete_response({:ok, _trainer_pokemon}, conn) do
    conn
    |> put_status(:no_content)
    |> text("")
  end

  defp handle_delete_response({:not_found, _reason} = error, _conn), do: error
  defp handle_delete_response({:error, _reason} = error, _conn), do: error

  defp handle_index_response({:ok, trainers_pokemon}, conn, view, status) do
    conn
    |> put_status(status)
    |> render(view, trainers_pokemon: trainers_pokemon)
  end

  defp handle_response({:ok, trainer_pokemon}, conn, view, status) do
    conn
    |> put_status(status)
    |> render(view, trainer_pokemon: trainer_pokemon)
  end

  defp handle_response({:not_found, _changeset} = error, _conn, _view, _status), do: error
  defp handle_response({:error, _changeset} = error, _conn, _view, _status), do: error
end
