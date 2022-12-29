defmodule ExPokemonWeb.TrainersView do
  use ExPokemonWeb, :view

  alias ExPokemon.Trainer

  def render("create.json", %{trainer: %Trainer{id: id, name: name, inserted_at: inserted_at}}) do
    %{
      message: "trainer created successfully",
      trainer: %{
        id: id,
        name: name,
        inserted_at: inserted_at
      }
    }
  end

  def render("update.json", %{trainer: %Trainer{id: id, name: name, inserted_at: inserted_at}}) do
    %{
      message: "trainer updated successfully",
      trainer: %{
        id: id,
        name: name,
        inserted_at: inserted_at
      }
    }
  end

  def render("show.json", %{trainer: %Trainer{id: id, name: name, inserted_at: inserted_at}}) do
    %{
      message: "",
      trainer: %{
        id: id,
        name: name,
        inserted_at: inserted_at
      }
    }
  end
end
