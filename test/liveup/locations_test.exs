defmodule Liveup.LocationsTest do
  use Liveup.DataCase

  alias Liveup.Locations

  describe "scenes" do
    alias Liveup.Locations.Scene

    import Liveup.LocationsFixtures

    @invalid_attrs %{name: nil, priority: nil}

    test "list_scenes/0 returns all scenes" do
      scene = scene_fixture()
      assert Locations.list_scenes() == [scene]
    end

    test "get_scene!/1 returns the scene with given id" do
      scene = scene_fixture()
      assert Locations.get_scene!(scene.id) == scene
    end

    test "create_scene/1 with valid data creates a scene" do
      valid_attrs = %{name: "some name", priority: 42}

      assert {:ok, %Scene{} = scene} = Locations.create_scene(valid_attrs)
      assert scene.name == "some name"
      assert scene.priority == 42
    end

    test "create_scene/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Locations.create_scene(@invalid_attrs)
    end

    test "update_scene/2 with valid data updates the scene" do
      scene = scene_fixture()
      update_attrs = %{name: "some updated name", priority: 43}

      assert {:ok, %Scene{} = scene} = Locations.update_scene(scene, update_attrs)
      assert scene.name == "some updated name"
      assert scene.priority == 43
    end

    test "update_scene/2 with invalid data returns error changeset" do
      scene = scene_fixture()
      assert {:error, %Ecto.Changeset{}} = Locations.update_scene(scene, @invalid_attrs)
      assert scene == Locations.get_scene!(scene.id)
    end

    test "delete_scene/1 deletes the scene" do
      scene = scene_fixture()
      assert {:ok, %Scene{}} = Locations.delete_scene(scene)
      assert_raise Ecto.NoResultsError, fn -> Locations.get_scene!(scene.id) end
    end

    test "change_scene/1 returns a scene changeset" do
      scene = scene_fixture()
      assert %Ecto.Changeset{} = Locations.change_scene(scene)
    end
  end
end
