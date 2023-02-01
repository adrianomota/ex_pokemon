import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :ex_pokemon, ExPokemon.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "ex_pokemon_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :ex_pokemon, ExPokemonWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "LACQdUy9zEGv7hIJTAjSHVMTHT1/BL/Aw5VuJPaU0HQ9Duq7kz6FdF5PHQaSxrSR",
  server: false

# In test we don't send emails.
config :ex_pokemon, ExPokemon.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# tesla
config :tesla, adapter: Tesla.Mock

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
