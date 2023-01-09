defmodule ExPokemonWeb.TrainerPokemonsView do
  use ExPokemonWeb, :view

  alias ExPokemon.Trainer.Pokemon

  def render("create.json", %{
        pokemon: %Pokemon{
          id: id,
          name: name,
          nickname: nickname,
          types: types,
          weight: weight,
          trainer_id: trainer_id
        }
      }) do
    %{
      message: "Trainer pokemon created successfully",
      pokemon: %{
        id: id,
        name: name,
        nickname: nickname,
        types: types,
        weight: weight,
        trainer_id: trainer_id
      }
    }
  end
end
