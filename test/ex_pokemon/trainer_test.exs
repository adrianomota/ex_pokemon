defmodule ExPokemon.TrainerTest do
  use ExPokemon.DataCase

  alias ExPokemon.Trainer

  describe "changeset/1" do
    test "When all params are valid, returns a valid changeset" do
      params = %{name: "Adriano teste", password: "123456"}

      response = Trainer.changeset(params)

      assert %Ecto.Changeset{
               changes: %{
                 name: "Adriano teste",
                 password: "123456"
               },
               errors: [],
               data: %Trainer{},
               valid?: true
             } = response
    end

    test "When all params are invalid, returns a invalid changeset" do
      params = %{password: "123456"}

      response = Trainer.changeset(params)

      assert %Ecto.Changeset{
               changes: %{
                 password: "123456"
               },
               data: %Trainer{},
               valid?: false
             } = response

      assert errors_on(response) == %{name: ["can't be blank"]}
    end

    test "WHen there are invalid params, returns an invalid changeset" do
    end
  end

  describe "build/0" do
    test "When all params are valid, returns a valid trainer struct" do
      params = %{name: "Adriano teste", password: "123456"}

      response = Trainer.build(params)

      assert {:ok, %Trainer{}} = response
    end

    test "When all params are invalid, returns a invalid trainer struct" do
      params = %{password: "123456"}

      {:error, response} = Trainer.build(params)

      assert %Ecto.Changeset{valid?: false} = response

      assert errors_on(response) == %{name: ["can't be blank"]}
    end
  end
end
