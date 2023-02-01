defmodule ExPokemonWeb.TrainersControllerTest do
  use ExPokemonWeb.ConnCase
  import ExPokemonWeb.Auth.Guardian
  alias ExPokemon.Trainer

  setup %{conn: conn} do
    {:ok, trainer} = %{name: "Trainer logged", password: "123456"} |> ExPokemon.create_trainer()
    {:ok, token, _} = encode_and_sign(trainer, %{}, token_type: :access)

    conn =
      conn
      |> put_req_header("accept", "application/json")
      |> put_req_header("authorization", "bearer " <> token)

    {:ok, conn: conn}
  end

  describe "create/2" do
    test "When there is valid params, returns new trainer created",
         %{conn: conn} do
      params = %{"name" => "Trainer 1", "password" => "123456"}

      response =
        conn
        |> post(Routes.trainers_path(conn, :create, params))
        |> json_response(:created)

      assert %{
               "trainer" => %{"name" => "Trainer 1"}
             } = response
    end
  end

  describe "show/2" do
    test "When there is a trainer with the given id, returns the trainer",
         %{conn: conn} do
      params = %{"name" => "Trainer 2", "password" => "123456"}

      {:ok, %Trainer{id: id}} = ExPokemon.create_trainer(params)

      response =
        conn
        |> get(Routes.trainers_path(conn, :show, id))
        |> json_response(:ok)

      assert %{
               "trainer" => %{"name" => "Trainer 2"}
             } = response
    end
  end

  describe "index/2" do
    test "When there is a trainer with the given id, returns the trainer",
         %{conn: conn} do
      params_1 = %{"name" => "Trainer 1", "password" => "123456"}
      params_2 = %{"name" => "Trainer 2", "password" => "123456"}
      params_3 = %{"name" => "Trainer 3", "password" => "123456"}

      {:ok, %Trainer{id: _id}} = ExPokemon.create_trainer(params_1)
      {:ok, %Trainer{id: _id}} = ExPokemon.create_trainer(params_2)
      {:ok, %Trainer{id: _id}} = ExPokemon.create_trainer(params_3)

      response =
        conn
        |> get(Routes.trainers_path(conn, :index, %{"page" => "1", "per_page" => "3"}))
        |> json_response(:ok)

      assert %{"count" => 4} = response
    end
  end

  describe "update/2" do
    test "When there is a trainer with the given id and we change your name, returns the trainer with name changed",
         %{conn: conn} do
      params = %{"name" => "Trainer to update", "password" => "123456"}

      {:ok, %Trainer{id: id}} = ExPokemon.create_trainer(params)

      response =
        conn
        |> put(
          Routes.trainers_path(conn, :update, id, %{
            "name" => "Trainer updated",
            "password" => "123456"
          })
        )
        |> json_response(:ok)

      assert %{
               "trainer" => %{"name" => "Trainer updated"}
             } = response
    end
  end

  describe "delete/2" do
    test "When there is a trainer with the given id and we remove trainer, returns ok",
         %{conn: conn} do
      params = %{"name" => "Trainer to remove", "password" => "123456"}

      {:ok, %Trainer{id: id}} = ExPokemon.create_trainer(params)

      response =
        conn
        |> delete(Routes.trainers_path(conn, :update, id))
        |> json_response(:ok)

      assert response == %{"message" => "Trainer deleted successfully"}
    end
  end
end
