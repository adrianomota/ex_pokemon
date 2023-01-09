defmodule ExPokemon.Trainer.Delete do
  alias Ecto.UUID
  alias ExPokemon.Repo
  alias ExPokemon.Trainer

  def call(id) do
    case UUID.cast(id) do
      :error -> {:error, "Invalid ID format"}
      {:ok, uuid} -> delete(uuid)
    end
  end

  defp delete(uuid) do
    case fetch_trainer(uuid) do
      nil -> {:not_found, "Trainer doesn't exists"}
      trainer -> Repo.delete(trainer)
    end
  end

  defp fetch_trainer(uuid), do: Repo.get(Trainer, uuid)
end
