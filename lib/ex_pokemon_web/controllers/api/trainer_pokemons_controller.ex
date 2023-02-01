defmodule ExPokemonWeb.TrainerPokemonsController do
  use ExPokemonWeb, :controller

  action_fallback ExPokemonWeb.FallbackController

  def index(conn, params) do
    with {:ok, trainers_pokemon} <- ExPokemon.paginate_trainers_pokemons(params) do
      conn
      |> put_status(:ok)
      |> render("index.json", trainers_pokemon: trainers_pokemon)
    end
  end

  def create(conn, params) do
    with {:ok, trainer_pokemon} <- ExPokemon.create_trainer_pokemon(params) do
      conn
      |> put_status(:crrated)
      |> render("created.json", trainer_pokemon: trainer_pokemon)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, trainer_pokemon} <- ExPokemon.fetch_trainer_pokemon(id) do
      conn
      |> put_status(:ok)
      |> render("show.json", trainer_pokemon: trainer_pokemon)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, trainer_pokmemon} <- ExPokemon.delete_trainer_pokemon(id) do
      conn
      |> put_status(:ok)
      |> render("delete.json", trainer_pokemon: trainer_pokmemon)
    end
  end
end
