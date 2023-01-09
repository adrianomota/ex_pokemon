defmodule ExPokemon.Trainer.Pokemon.Delete do
  alias Ecto.UUID
  alias ExPokemon.Repo
  alias ExPokemon.Trainer.Pokemon

  def call(id) do
    case UUID.cast(id) do
      :error -> {:error, "invalid ID format"}
      {:ok, _UUID} -> delete(id)
    end
  end

  defp delete(uuid) do
    case fetch_pokemon(uuid) do
      nil -> {:error, "Pokemon doesn't exists"}
      pokemon -> Repo.delete!(pokemon)
    end
  end

  defp fetch_pokemon(uuid), do: Repo.get(Pokemon, uuid)
end
