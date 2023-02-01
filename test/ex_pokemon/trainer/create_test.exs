defmodule ExPokemon.Trainer.CreateTest do
  use ExPokemon.DataCase

  alias ExPokemon.{Repo, Trainer}
  alias ExPokemon.Trainer.Create

  describe "call/1" do
    test "When all params are valid, create a trainer" do
      params = %{name: "Adriano", password: "123456"}
      count_before = Repo.aggregate(Trainer, :count)
      response = Create.call(params)
      count_after = Repo.aggregate(Trainer, :count)
      assert {:ok, %Trainer{name: "Adriano"}} = response
      assert count_after > count_before
    end

    test "When all params are invalid, returns the error" do
      params = %{name: "Adriano"}
      response = Create.call(params)

      assert {:error, changeset} = response
      assert errors_on(changeset) == %{password: ["can't be blank"]}
    end
  end
end
