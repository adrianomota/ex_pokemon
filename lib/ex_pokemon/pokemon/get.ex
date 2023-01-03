defmodule ExPokemon.Pokemon.Get do
  alias ExPokemon.PokeApi.Client
  alias ExPokemon.Pokemon

  def call(name) do
    name
    |> Client.get_pokemon()
    |> handle_response()
  end

  defp handle_response({:ok, body}) do
    {:ok, Pokemon.build(body)}
  end

  defp handle_response({:error, _reason} = error) do
    error
  end
end
