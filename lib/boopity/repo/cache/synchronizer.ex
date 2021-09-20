defmodule Boopity.Repo.Cache.Synchronizer do
  alias Boopity.Repo.Cache

  use GenServer

  @refresh_time :timer.seconds(10)

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts)
  end

  @impl GenServer
  def init(opts) do
    cache = Keyword.fetch!(opts, :cache)

    send(self(), :sync)

    {:ok, cache}
  end

  @impl GenServer
  def handle_info(:sync, cache) do
    with {:ok, items} <- apply(cache, :fetch_fn, []).() do
      Cache.set_all(cache, items)
    end

    schedule()

    {:noreply, cache}
  end

  defp schedule do
    Process.send_after(self(), :sync, @refresh_time)
  end
end
