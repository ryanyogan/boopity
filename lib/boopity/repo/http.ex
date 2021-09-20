defmodule Boopity.Repo.Http do
  alias __MODULE__.Decoder
  alias Boopity.{Pet, Medication, Repo}
  alias Services.Airtable

  @behaviour Repo

  @pets_table "pets"
  @medications_table "medications"

  @impl Repo
  def all(Pet), do: do_all(@pets_table)
  def all(Medication), do: do_all(@medications_table)

  @impl Repo
  def get(Pet, id), do: do_get(@pets_table, id)
  def get(Medication, id), do: do_get(@medications_table, id)

  defp do_all(table) do
    case Airtable.all(table) do
      {:ok, %{"records" => records}} ->
        {:ok, Decoder.decode(records)}

      {:error, 404} ->
        {:error, :not_found}

      other ->
        other
    end
  end

  defp do_get(table, id) do
    case Airtable.get(table, id) do
      {:ok, response} ->
        {:ok, Decoder.decode(response)}

      {:error, 404} ->
        {:error, :not_found}

      other ->
        other
    end
  end
end
