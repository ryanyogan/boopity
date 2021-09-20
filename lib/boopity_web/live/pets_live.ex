defmodule BoopityWeb.PetsLive do
  use BoopityWeb, :live_view

  alias BoopityWeb.LiveEncoder

  @topic "pets"

  @impl true
  def mount(_params, _session, socket) do
    BoopityWeb.Endpoint.subscribe(@topic)

    {:ok, assign_socket(socket)}
  end

  def render_pet(socket, pet) do
    Phoenix.View.render(BoopityWeb.PageView, "pet.html", socket: socket, pet: pet)
  end

  @impl true
  def handle_info(%{event: "update"}, socket) do
    IO.puts("UPDA")
    IO.inspect(socket)
    {:noreply, assign_socket(socket)}
  end

  defp assign_socket(socket) do
    case fetch_pets() do
      {:ok, pets} ->
        socket
        |> assign(page_title: "Boopity Dashboard")
        |> assign(pets: pets)
        |> put_flash(:error, nil)

      _ ->
        socket
        |> assign(page_title: "Boopity Dashboard")
        |> assign(pets: nil)
        |> put_flash(:error, "Error fetching pet data")
    end
  end

  defp fetch_pets do
    with {:ok, pets} <- Boopity.pets() do
      pets =
        pets
        |> Enum.sort_by(& &1.dob)
        |> LiveEncoder.pets()

      {:ok, pets}
    end
  end
end
