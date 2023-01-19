defmodule ExPokemon.Trainer.Pokemon.Paginate do
  alias ExPokemon.Pagination
  alias ExPokemon.Trainer.Pokemon

  def call(params), do: {:ok, Pagination.page(Pokemon, params)}
end
