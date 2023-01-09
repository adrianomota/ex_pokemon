defmodule ExPokemon.Trainer.Pokemon do
  use Ecto.Schema

  import Ecto.Changeset

  alias ExPokemon.Trainer

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "pokemons" do
    field :name, :string
    field :nickname, :string
    field :weight, :integer
    field :types, {:array, :string}

    belongs_to :trainer, Trainer
    timestamps()
  end

  @required [:name, :nickname, :weight, :types, :trainer_id]

  def build(params) do
    params
    |> changeset()
    |> apply_action(:insert)
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required)
    |> validate_required(@required)
    |> assoc_constraint(:trainer)
    |> validate_length(:nickname, min: 2)
  end
end
