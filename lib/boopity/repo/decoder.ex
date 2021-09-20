defmodule Boopity.Repo.Http.Decoder do
  @moduledoc false

  alias Boopity.{Pet, Medication}

  def decode(response) when is_list(response) do
    Enum.map(response, &decode/1)
  end

  def decode(%{
        "id" => id,
        "fields" =>
          %{
            "animal" => animal
          } = fields
      }) do
    %Pet{
      id: id,
      name: Map.get(fields, "name", ""),
      notes: Map.get(fields, "notes", ""),
      image: decode_image(Map.get(fields, "image")),
      animal: animal,
      vet_visits: Map.get(fields, "vet_visits", []),
      sex: Map.get(fields, "sex", []),
      dob: Map.get(fields, "dob", ""),
      medications: Map.get(fields, "medications", [])
    }
  end

  def decode(%{
        "id" => id,
        "fields" =>
          %{
            "dosage" => dosage
          } = fields
      }) do
    %Medication{
      id: id,
      name: Map.get(fields, "name", ""),
      dosage: dosage,
      frequency: Map.get(fields, "frequency", ""),
      condition: Map.get(fields, "condition", ""),
      image: decode_image(Map.get(fields, "image", "")),
      pets: Map.get(fields, "pets", [])
    }
  end

  defp decode_image([%{"url" => url}]), do: url
  defp decode_image(_), do: ""
end
