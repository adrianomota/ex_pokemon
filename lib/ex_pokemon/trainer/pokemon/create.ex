defmodule ExPokemon.Trainer.Pokemon.Create do
  alias Ecto.UUID
  alias ExPokemon.PokeApi.Client
  alias ExPokemon.{Pokemon, Repo, Trainer}
  alias ExPokemon.Trainer.Pokemon, as: TrainerPokemon

  def call(%{"name" => name, "trainer_id" => trainer_id} = params) do
    case UUID.cast(trainer_id) do
      :error -> {:error, "Invalid ID format"}
      {:ok, _uuid} -> trainer_id?(name, params)
    end
  end

  defp trainer_id?(name, %{"trainer_id" => trainer_id} = params) do
    case fetch_trainer(trainer_id) do
      nil -> {:error, "Trainer doesn't exists"}
      _trainer -> create(name, params)
    end
  end

  defp create(name, params) do
    name
    |> Client.get_pokemon()
    |> handle_response(params)
  end

  defp fetch_trainer(uuid), do: Repo.get(Trainer, uuid)

  defp handle_response({:ok, body}, params) do
    body
    |> Pokemon.build()
    |> create_pokemon(params)
  end

  defp handle_response({:not_found, _reason} = error, _params), do: error
  defp handle_response({:error, _reason} = error, _params), do: error

  defp create_pokemon(
         %Pokemon{name: name, weight: weight, types: types},
         %{
           "nickname" => nickname,
           "trainer_id" => trainer_id
         }
       ) do
    params = %{
      name: name,
      nickname: nickname,
      weight: weight,
      types: types,
      trainer_id: trainer_id
    }

    params
    |> TrainerPokemon.build()
    |> handle_build()
  end

  defp handle_build({:ok, pokemon}), do: Repo.insert(pokemon)
  defp handle_build({:error, _changeset} = error), do: error
end
