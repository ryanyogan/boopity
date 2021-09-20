defmodule BoopityWeb.ShowPetLive do
  use BoopityWeb, :live_view

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    {:ok, assign_socket(socket, id)}
  end

  defp assign_socket(socket, id) do
    case Boopity.get_pet(id) do
      {:ok, pet} ->
        socket
        |> assign(:page_title, pet.name)
        |> assign(:pet, pet)
        |> put_flash(:error, nil)

      {:error, _} ->
        socket
        |> assign(:page_title, "Pets")
        |> assign(:pet, nil)
        |> put_flash(:error, "Error fetching pet data")
    end
  end
end
