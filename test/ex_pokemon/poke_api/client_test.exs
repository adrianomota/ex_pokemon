defmodule ExPokemon.PokeApi.ClientTest do
  use ExUnit.Case
  import Tesla.Mock

  alias ExPokemon.PokeApi.Client

  @base_url "https://pokeapi.co/api/v2/pokemon"
  describe "get pokemon/1" do
    test "when there is a pokemon with the given name, returns the pokemon" do
      body = %{
        "name" => "pikachu",
        "weight" => 60,
        "types" => ["eletric"]
      }

      mock(fn %{method: :get, url: "#{@base_url}/pikachu"} ->
        %Tesla.Env{status: 200, body: body}
      end)

      response = Client.get_pokemon("pikachu")

      expect_response =
        {:ok,
         %{
           "name" => "pikachu",
           "weight" => 60,
           "types" => ["eletric"]
         }}

      assert response == expect_response
    end

    test "when there isn't a pokemon with the given name, returns the error" do
      mock(fn %{method: :get, url: "#{@base_url}/not_found"} ->
        %Tesla.Env{status: 404}
      end)

      response = Client.get_pokemon("not_found")

      expect_response = {:not_found, "Pokemon not found"}

      assert response == expect_response
    end

    test "when there is a unexpeicted error, returns the error" do
      mock(fn %{method: :get, url: "#{@base_url}/pikachu"} ->
        {:error, :timeout}
      end)

      response = Client.get_pokemon("pikachu")

      expect_response = {:error, :timeout}

      assert response == {:error, :timeout}
    end
  end
end
