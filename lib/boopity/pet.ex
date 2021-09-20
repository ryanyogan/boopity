defmodule Boopity.Pet do
  alias __MODULE__

  @type t() :: %Pet{
          id: String.t(),
          name: String.t(),
          notes: String.t(),
          image: String.t(),
          animal: String.t(),
          sex: String.t(),
          dob: Date.t(),
          medications: [String.t()]
        }

  defstruct [
    :id,
    :name,
    :notes,
    :image,
    :animal,
    :vet_visits,
    :sex,
    :dob,
    :medications
  ]
end
