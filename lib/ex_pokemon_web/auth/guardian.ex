defmodule ExPokemonWeb.Auth.Guardian do
  use Guardian, otp_app: :ex_pokemon

  alias ExPokemon.Trainer

  @message_error "Invalid user or password!"

  def subject_for_token(%{id: id}, _claims) do
    sub = to_string(id)
    {:ok, sub}
  end

  def resource_from_claims(claims) do
    claims
    |> Map.get("sub")
    |> ExPokemon.fetch_trainer()
  end

  def authenticate(%{"id" => trainer_id, "password" => password}) do
    case ExPokemon.fetch_trainer(trainer_id) do
      {:error, _reason} -> {:unauthorized, @message_error}
      {:ok, trainer} -> validate_password(trainer, password)
    end
  end

  def validate_password(%Trainer{password_hash: hash} = trainer, password) do
    case Argon2.verify_pass(password, hash) do
      true -> create_token(trainer)
      false -> {:unauthorized, @message_error}
    end
  end

  defp create_token(trainer) do
    {:ok, token, _claims} = encode_and_sign(trainer)
    {:ok, token}
  end
end
