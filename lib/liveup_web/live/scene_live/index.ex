defmodule LiveupWeb.SceneLive.Index do
  use LiveupWeb, :live_view

  alias Liveup.Locations
  alias Liveup.Locations.Scene

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :scenes, Locations.list_scenes())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Scene")
    |> assign(:scene, Locations.get_scene!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Scene")
    |> assign(:scene, %Scene{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Scenes")
    |> assign(:scene, nil)
  end

  @impl true
  def handle_info({LiveupWeb.SceneLive.FormComponent, {:saved, scene}}, socket) do
    {:noreply, stream_insert(socket, :scenes, scene)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    scene = Locations.get_scene!(id)
    {:ok, _} = Locations.delete_scene(scene)

    {:noreply, stream_delete(socket, :scenes, scene)}
  end
end
