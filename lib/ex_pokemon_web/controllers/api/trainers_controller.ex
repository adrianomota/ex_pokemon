defmodule ExPokemonWeb.TrainersController do
  use ExPokemonWeb, :controller

  action_fallback(ExPokemonWeb.FallbackController)

  def index(conn, params) do
    ExPokemon.paginate_trainers(params)
    |> IO.inspect()
    |> handle_index_response(conn, "index.json", :ok)
  end

  def show(conn, %{"id" => id}) do
    id
    |> ExPokemon.fetch_trainer()
    |> handle_response(conn, "show.json", :ok)
  end

  def create(conn, params) do
    params
    |> ExPokemon.create_trainer()
    |> handle_response(conn, "create.json", :created)
  end

  def update(conn, params) do
    params
    |> ExPokemon.update_trainer()
    |> handle_response(conn, "update.json", :ok)
  end

  def delete(conn, %{"id" => id}) do
    id
    |> ExPokemon.delete_trainer()
    |> handle_delete_response(conn)
  end

  defp handle_delete_response({:ok, _trainer}, conn) do
    conn
    |> put_status(:no_content)
    |> text("")
  end

  defp handle_delete_response({:error, _reason} = error, _conn), do: error

  defp handle_index_response({:ok, trainers}, conn, view, status) do
    conn
    |> put_status(status)
    |> render(view, trainers: trainers)
  end

  defp handle_index_response({:error, _changeset} = error, _conn, _view, _status), do: error

  defp handle_response({:ok, trainer}, conn, view, status) do
    conn
    |> put_status(status)
    |> render(view, trainer: trainer)
  end

  defp handle_response({:error, _changeset} = error, _conn, _view, _status), do: error
end
