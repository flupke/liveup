defmodule LiveupWeb.EventLive.Show do
  use LiveupWeb, :live_view

  alias Liveup.Schedule

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:event, Schedule.get_event!(id))}
  end

  defp page_title(:show), do: "Show Event"
  defp page_title(:edit), do: "Edit Event"
end
