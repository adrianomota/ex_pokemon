defmodule ExPokemonWeb.TrainersView do
  use ExPokemonWeb, :view

  alias ExPokemon.Trainer

  def render("create.json", %{trainer: %Trainer{id: id, name: name, inserted_at: inserted_at}}) do
    %{
      message: "trainer created",
      trainer: %{
        id: id,
        name: name,
        inserted_at: inserted_at
      }
    }
  end
end
