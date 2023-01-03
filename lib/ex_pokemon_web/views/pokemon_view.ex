defmodule ExPokemonWeb.PokemonView do
  use ExPokemonWeb, :view

  def render("404.json", %{result: message}) do
    %{message: message}
  end
end
