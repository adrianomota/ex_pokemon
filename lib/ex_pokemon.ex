defmodule ExPokemon do
  @moduledoc """
  ExPokemon keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  alias ExPokemon.{Pokemon, Trainer}
  alias ExPokemon.Trainer.Pokemon, as: TrainerPokemon

  defdelegate create_trainer(params), to: Trainer.Create, as: :call
  defdelegate delete_trainer(id), to: Trainer.Delete, as: :call
  defdelegate fetch_trainer(id), to: Trainer.Fetch, as: :call
  defdelegate paginate_trainers(params), to: Trainer.Paginate, as: :call
  defdelegate update_trainer(params), to: Trainer.Update, as: :call
  defdelegate fetch_pokemon(name), to: Pokemon.Get, as: :call
  defdelegate create_trainer_pokemon(params), to: TrainerPokemon.Create, as: :call
end
