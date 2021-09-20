defmodule Boopity.Repo.Cache do
  @moduledoc """
  Cache module for the repo
  """
  use GenServer

  require Logger

  @callback table_name :: atom()
  @callback start_link(keyword) :: GenServer.on_start()

  def all(cache) do
    cache
    |> table_for()
    |> :ets.tab2list()
    |> case do
      values when values != [] ->
        Logger.info("#{cache}.all hit")

        {:ok, Enum.map(values, &elem(&1, 1))}

      _ ->
        Logger.info("#{cache}.all miss")

        {:error, :not_found}
    end
  end

  def get(cache, key) do
    cache
    |> table_for()
    |> :ets.lookup(key)
    |> case do
      [{^key, value} | _] ->
        Logger.info("#{cache}.get #{key} hit")
        {:ok, value}

      _ ->
        Logger.info("#{cache}.get #{key} miss")
        {:error, :not_found}
    end
  end

  def set_all(cache, items), do: GenServer.cast(cache, {:set_all, items})

  def set(cache, id, item), do: GenServer.cast(cache, {:set, id, item})

  @impl GenServer
  def init(name) do
    name
    |> table_for()
    |> :ets.new([:ordered_set, :protected, :named_table])

    {:ok, %{name: name}}
  end

  @impl GenServer
  def handle_cast({:set_all, items}, %{name: name} = state)
      when is_list(items) do
    Logger.info("#{name}.set_all setting new items and broadcasting")

    Enum.each(items, &:ets.insert(table_for(name), {&1.id, &1}))
    {:noreply, state}
  end

  def handle_cast({:set, id, item}, %{name: name} = state) do
    name
    |> table_for()
    |> :ets.insert({id, item})

    {:noreply, state}
  end

  defp table_for(name), do: apply(name, :table_name, [])
end
