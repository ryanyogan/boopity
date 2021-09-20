defmodule Boopity.Medication do
  alias __MODULE__

  @type t() :: %Medication{
          id: String.t(),
          name: String.t(),
          dosage: String.t(),
          frequency: String.t(),
          condition: String.t(),
          image: String.t(),
          pets: [String.t()]
        }

  defstruct [
    :id,
    :name,
    :dosage,
    :frequency,
    :condition,
    :image,
    :pets
  ]
end
