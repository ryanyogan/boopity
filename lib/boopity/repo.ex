defmodule Boopity.Repo do
  alias Boopity.{Pet, Medication}
  alias Boopity.Repo.Cache

  @type entity_types :: Pet.t() | Medication.t()

  @callback all(Pet | Medication) :: {:ok, [entity_types()]} | {:error, term}
  @callback get(Pet | Medication, String.t()) :: {:ok, [entity_types()]} | {:error, term}

  @adapter Application.get_env(:boopity, __MODULE__)[:adapter]

  def pets(skip_cache \\ false)
  def pets(false), do: all(Pet)
  def pets(true), do: @adapter.all(Pet)

  # def medications(skip_cache \\ false)
  # def medications(false), do: all(Medication)
  def medications, do: @adapter.all(Medication)

  def get_pet(id), do: get(Pet, id)

  defp all(entity) do
    with cache <- cache_for(entity),
         {:error, :not_found} <- Cache.all(entity),
         {:ok, pets} <- @adapter.all(entity) do
      Cache.set_all(cache, pets)
      {:ok, pets}
    end
  end

  defp get(entity, id) do
    with cache <- cache_for(entity),
         {:error, :not_found} <- Cache.get(cache, id),
         {:ok, pet} <- @adapter.get(entity, id) do
      Cache.set(cache, id, pet)
      {:ok, pet}
    end
  end

  defp cache_for(Pet), do: Boopity.Pet.Cache
  # defp cache_for(Medication), do: Boopity.Medication.Cache
end
