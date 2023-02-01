defmodule ExPokemon.Trainer.Pokemon.Delete do
  alias Ecto.UUID
  alias ExPokemon.Repo
  alias ExPokemon.Trainer.Pokemon

  def call(id) do
    case UUID.cast(id) do
      :error -> {:error, "invalid ID format"}
      {:ok, uuid} -> delete_trainer_pokemon(uuid)
    end
  end

  defp delete_trainer_pokemon(uuid) do
    case fetch_pokemon(uuid) do
      nil -> {:not_found, "Pokemon doesn't exists"}
      trainer_pokemon -> {:ok, Repo.delete!(trainer_pokemon)}
    end
  end

  defp fetch_pokemon(uuid), do: Repo.get(Pokemon, uuid)
end
