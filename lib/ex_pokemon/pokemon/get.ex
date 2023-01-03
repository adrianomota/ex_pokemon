defmodule ExPokemon.Pokemon.Get do
  alias ExPokemon.PokeApi.Client
  alias ExPokemon.Pokemon

  def call(name) do
    name
    |> Client.get_pokemon()
    |> handle_response()
  end

  defp handle_response({:ok, body}), do: {:ok, Pokemon.build(body)}

  defp handle_response({:not_found, message: message}),
    do: {message, 404}

  defp handle_response({:error, _reason} = error), do: error
end
