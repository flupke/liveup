defmodule LiveupWeb.SceneLive.FormComponent do
  use LiveupWeb, :live_component

  alias Liveup.Locations

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage scene records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="scene-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:priority]} type="number" label="Priority" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Scene</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{scene: scene} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Locations.change_scene(scene))
     end)}
  end

  @impl true
  def handle_event("validate", %{"scene" => scene_params}, socket) do
    changeset = Locations.change_scene(socket.assigns.scene, scene_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"scene" => scene_params}, socket) do
    save_scene(socket, socket.assigns.action, scene_params)
  end

  defp save_scene(socket, :edit, scene_params) do
    case Locations.update_scene(socket.assigns.scene, scene_params) do
      {:ok, scene} ->
        notify_parent({:saved, scene})

        {:noreply,
         socket
         |> put_flash(:info, "Scene updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_scene(socket, :new, scene_params) do
    case Locations.create_scene(scene_params) do
      {:ok, scene} ->
        notify_parent({:saved, scene})

        {:noreply,
         socket
         |> put_flash(:info, "Scene created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
