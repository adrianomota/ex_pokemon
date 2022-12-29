defmodule ExPokemon.Trainer.Update do
  alias Ecto.UUID
  alias ExPokemon.Repo
  alias ExPokemon.Trainer

  def call(%{"id" => id} = params) do
    case UUID.cast(id) do
      :error -> {:error, "Invalid ID format"}
      {:ok, _uuid} -> update(params)
    end
  end

  defp update(%{"id" => id} = params) do
    case fetch_trainer(id) do
      nil -> {:error, "Trainer doesn't exists"}
      trainer -> update_trainer(trainer, params)
    end
  end

  defp update_trainer(trainer, params) do
    trainer
    |> Trainer.changeset(params)
    |> Repo.update()
  end

  defp fetch_trainer(uuid), do: Repo.get(Trainer, uuid)
end
