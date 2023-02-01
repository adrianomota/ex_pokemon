defmodule ExPokemonWeb.TrainersController do
  use ExPokemonWeb, :controller

  alias ExPokemonWeb.Auth.Guardian

  action_fallback(ExPokemonWeb.FallbackController)

  def index(conn, params) do
    with {:ok, trainers} <- ExPokemon.paginate_trainers(params) do
      conn
      |> put_status(:ok)
      |> render("index.json", trainers: trainers)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, trainer} <- ExPokemon.fetch_trainer(id) do
      conn
      |> put_status(:ok)
      |> render("show.json", trainer: trainer)
    end
  end

  def create(conn, params) do
    with {:ok, trainer} <- ExPokemon.create_trainer(params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(trainer) do
      conn
      |> put_status(:created)
      |> render("create.json", %{trainer: trainer, token: token})
    end
  end

  def update(conn, params) do
    with {:ok, trainer} <- ExPokemon.update_trainer(params) do
      conn
      |> put_status(:ok)
      |> render("update.json", trainer: trainer)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, _traijner} <- ExPokemon.delete_trainer(id) do
      conn
      |> put_status(:ok)
      |> render("delete.json", %{})
    end
  end
end
