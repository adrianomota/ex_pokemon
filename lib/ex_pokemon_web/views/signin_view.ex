defmodule ExPokemonWeb.SigninView do
  use ExPokemonWeb, :view

  def render("sign_in.json", %{token: token}) do
    %{
      message: "Token created successfully",
      token: token
    }
  end
end
