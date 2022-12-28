defmodule ExPokemon.Repo do
  use Ecto.Repo,
    otp_app: :ex_pokemon,
    adapter: Ecto.Adapters.Postgres
end
