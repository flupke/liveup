defmodule LiveupWeb.EventLive.Index do
  use LiveupWeb, :live_view

  alias Liveup.Schedule
  alias Liveup.Schedule.Event
  alias Liveup.Repo

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     stream(
       socket,
       :events,
       Schedule.list_events()
       |> Repo.preload(:scene)
     )}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Event")
    |> assign(:event, Schedule.get_event!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Event")
    |> assign(:event, %Event{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Events")
    |> assign(:event, nil)
  end

  @impl true
  def handle_info({LiveupWeb.EventLive.FormComponent, {:saved, event}}, socket) do
    {:noreply, stream_insert(socket, :events, event |> Repo.preload(:scene))}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    event = Schedule.get_event!(id)
    {:ok, _} = Schedule.delete_event(event)

    {:noreply, stream_delete(socket, :events, event)}
  end
end
