defmodule LiveupWeb.SceneLive.CurrentUpcoming do
  use LiveupWeb, :naked_live_view

  alias Liveup.Schedule
  alias Liveup.Locations

  @tick_interval 1000

  @impl true
  def mount(%{"scene_id" => scene_id}, _session, socket) do
    socket =
      socket
      |> assign(:scene, Locations.get_scene!(scene_id))
      |> assign(:layout, false)
      |> assign_current_and_upcoming_events()

    if connected?(socket) do
      :timer.send_interval(@tick_interval, self(), :tick)
    end

    {:ok, socket}
  end

  @impl true
  def handle_info(:tick, socket) do
    {:noreply, assign_current_and_upcoming_events(socket)}
  end

  defp assign_current_and_upcoming_events(socket) do
    utc_now = DateTime.utc_now()
    all_events = Schedule.list_scene_events(socket.assigns.scene)
    [current_event, upcoming_event] = find_current_event(all_events, utc_now)

    socket
    |> assign(:current_event, current_event)
    |> assign(:upcoming_event, upcoming_event)
    |> assign(:utc_now, utc_now)
  end

  defp find_current_event(all_events, utc_now) do
    all_events
    |> Enum.chunk_every(2, 1, [nil])
    |> Enum.reverse()
    |> Enum.find([nil, hd(all_events)], fn [event, _next_event] ->
      compare = DateTime.compare(event.start, utc_now)
      compare == :lt or compare == :eq
    end)
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="h-screen w-screen bg-cover bg-center bg-no-repeat font-Charter text-schedule text-[10vw] bg-[url('/images/background.jpg')]">
      <%= if @current_event do %>
        <div class="p-10">{@current_event.name}</div>
      <% end %>
      <%= if @upcoming_event do %>
        <div class="fixed bottom-0 right-0 p-10 w-full text-6xl text-right">
          Next: {@upcoming_event.start |> Calendar.strftime("%H:%M")} {@upcoming_event.name}
        </div>
      <% end %>
    </div>
    """
  end
end
