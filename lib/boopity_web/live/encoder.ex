defmodule BoopityWeb.LiveEncoder do
  alias Boopity.Pet

  def pets(pets) do
    Enum.map(pets, &encode/1)
  end

  defp encode(%Pet{} = pet) do
    Map.take(pet, [
      :id,
      :name,
      :notes,
      :image,
      :animal,
      :vet_visits,
      :sex,
      :dob,
      :medications
    ])
  end
end
