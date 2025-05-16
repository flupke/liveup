defmodule LiveupWeb.SceneLive.Show do
  use LiveupWeb, :live_view

  alias Liveup.Locations

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:scene, Locations.get_scene!(id))}
  end

  defp page_title(:show), do: "Show Scene"
  defp page_title(:edit), do: "Edit Scene"
end
