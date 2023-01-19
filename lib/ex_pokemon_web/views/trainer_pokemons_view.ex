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

  def render("index.json", %{trainers_pokemon: trainers_pokemon}) do
    %{
      count: trainers_pokemon.count,
      first: trainers_pokemon.first,
      has_prev: trainers_pokemon.has_prev,
      has_next: trainers_pokemon.has_next,
      last: trainers_pokemon.last,
      page: trainers_pokemon.page,
      prev_page: trainers_pokemon.prev_page,
      next_page: trainers_pokemon.next_page,
      trainers:
        Enum.map(trainers_pokemon.list, fn trainer_pokemon ->
          %{
            id: trainer_pokemon.id,
            name: trainer_pokemon.name,
            nickname: trainer_pokemon.nickname,
            types: trainer_pokemon.types,
            weight: trainer_pokemon.weight,
            trainer_id: trainer_pokemon.trainer_id
          }
        end)
    }
  end

  def render("update.json", %{
        trainers_pokemon: %Pokemon{
          id: id,
          name: name,
          nickname: nickname,
          types: types,
          weight: weight,
          trainer_id: trainer_id
        }
      }) do
    %{
      message: "trainer pokemon updated successfully",
      trainer_pokemon: %{
        id: id,
        name: name,
        nickname: nickname,
        types: types,
        weight: weight,
        trainer_id: trainer_id
      }
    }
  end

  def render("show.json", %{
        trainer_pokemon: %Pokemon{
          id: id,
          name: name,
          nickname: nickname,
          types: types,
          weight: weight,
          trainer_id: trainer_id
        }
      }) do
    %{
      message: "",
      trainer_pokemon: %{
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
