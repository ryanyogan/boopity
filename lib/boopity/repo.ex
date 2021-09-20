defmodule Boopity.Repo do
  alias Boopity.{Pet, Medication}

  @type entity_types :: Pet.t() | Medication.t()

  @callback all(Pet | Medication) :: {:ok, [entity_types()]} | {:error, term}
  @callback get(Pet | Medication, String.t()) :: {:ok, [entity_types()]} | {:error, term}

  @adapter Application.get_env(:boopity, __MODULE__)[:adapter]

  def pets, do: @adapter.all(Pet)

  def medications, do: @adapter.all(Medication)

  def get_pet(id), do: @adapter.get(Pet, id)
end
