defmodule Boopity do
  @moduledoc """
  Boopity keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  defdelegate pets, to: Boopity.Repo
  defdelegate medications, to: Boopity.Repo
  defdelegate get_pet(id), to: Boopity.Repo
end
