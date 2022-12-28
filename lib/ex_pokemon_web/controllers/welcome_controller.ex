defmodule ExPokemonWeb.WelcomeController do
  use ExPokemonWeb, :controller

  def index(conn, _paraams) do
    text(conn, "Welcome to ExMon Api")
  end
end
