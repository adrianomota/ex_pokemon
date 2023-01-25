defmodule ExPokemon.Trainer.Fetch do
  alias Ecto.UUID
  alias ExPokemon.Repo
  alias ExPokemon.Trainer

  def call(id) do
    case UUID.cast(id) do
      :error -> {:error, "Invalid ID format"}
      {:ok, uuid} -> fetch(uuid)
    end
  end

  defp fetch(uuid) do
    case fetch_trainer(uuid) do
      nil -> {:error, "Trainer doesn't exists"}
      trainer -> {:ok, trainer}
    end
  end

  defp fetch_trainer(uuid), do: Repo.get(Trainer, uuid)
end
