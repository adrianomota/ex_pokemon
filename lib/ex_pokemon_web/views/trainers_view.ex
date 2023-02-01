defmodule ExPokemonWeb.TrainersView do
  use ExPokemonWeb, :view

  alias ExPokemon.Trainer

  def render("create.json", %{
        trainer: %Trainer{id: id, name: name, inserted_at: inserted_at},
        token: token
      }) do
    %{
      message: "trainer created successfully",
      trainer: %{
        id: id,
        name: name,
        inserted_at: inserted_at
      },
      token: token
    }
  end

  def render("index.json", %{trainers: trainers}) do
    %{
      count: trainers.count,
      first: trainers.first,
      has_prev: trainers.has_prev,
      has_next: trainers.has_next,
      last: trainers.last,
      page: trainers.page,
      prev_page: trainers.prev_page,
      next_page: trainers.next_page,
      trainers:
        Enum.map(trainers.list, fn trainer ->
          %{
            id: trainer.id,
            name: trainer.name,
            inserted_at: trainer.inserted_at,
            updated_at: trainer.updated_at
          }
        end)
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

  def render("delete.json", %{}) do
    %{message: "Trainer deleted successfully"}
  end
end
