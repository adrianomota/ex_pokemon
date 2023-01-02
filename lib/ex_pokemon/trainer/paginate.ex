defmodule ExPokemon.Trainer.Paginate do
  alias ExPokemon.{Pagination, Trainer}

  def call(params) do
    {:ok, Pagination.page(Trainer, params)}
  end
end
