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
    now = DateTime.utc_now() |> DateTime.to_naive()
    all_events = Schedule.list_scene_events(socket.assigns.scene)
    [current_event, upcoming_event] = find_current_event(all_events, now)

    socket
    |> assign(:current_event, current_event)
    |> assign(:upcoming_event, upcoming_event)
    |> assign(:now, now)
  end

  defp find_current_event(all_events, now) do
    all_events
    |> Enum.chunk_every(2, 1, [nil])
    |> Enum.reverse()
    |> Enum.find([nil, hd(all_events)], fn [event, _next_event] ->
      compare = NaiveDateTime.compare(event.start, now)
      compare == :lt or compare == :eq
    end)
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="fixed inset-0 z-50 pointer-events-none">
      <img
        src="/images/arbres2rose.png"
        class="absolute inset-0 w-full h-full object-cover opacity-50"
      />
    </div>

    <div class="h-screen w-screen bg-cover bg-center bg-no-repeat bg-[#917a44] p-10">
      <%= if @current_event do %>
        <div class="font-Charter text-schedule text-[5em]">{@current_event.name}</div>
      <% end %>
      <%= if @upcoming_event do %>
        <div class="fixed bottom-0 right-0 w-full font-EurostileLTStd text-schedule-text-outline text-right text-[2em] pr-10">
          Next: {@upcoming_event.start |> Calendar.strftime("%H:%M")} {@upcoming_event.name}
        </div>
      <% end %>
    </div>
    """
  end
end
