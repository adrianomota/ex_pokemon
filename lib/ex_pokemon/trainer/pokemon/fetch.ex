defmodule ExPokemon.Trainer.Pokemon.Fetch do
  alias Ecto.UUID
  alias ExPokemon.Repo
  alias ExPokemon.Trainer.Pokemon

  def call(id) do
    case UUID.cast(id) do
      :error -> {:error, "Invalid format"}
      {:ok, uuid} -> fetch(uuid)
    end
  end

  defp fetch(uuid) do
    case fetch_trainer_pokemon(uuid) do
      nil -> {:error, "Trainer Pokemon doesn't exists"}
      trainer_pokemon -> {:ok, trainer_pokemon}
    end
  end

  defp fetch_trainer_pokemon(uuid), do: Repo.get(Pokemon, uuid)
end
