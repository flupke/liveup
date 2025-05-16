defmodule LiveupWeb.SceneLiveTest do
  use LiveupWeb.ConnCase

  import Phoenix.LiveViewTest
  import Liveup.LocationsFixtures

  @create_attrs %{name: "some name", priority: 42}
  @update_attrs %{name: "some updated name", priority: 43}
  @invalid_attrs %{name: nil, priority: nil}

  defp create_scene(_) do
    scene = scene_fixture()
    %{scene: scene}
  end

  describe "Index" do
    setup [:create_scene]

    test "lists all scenes", %{conn: conn, scene: scene} do
      {:ok, _index_live, html} = live(conn, ~p"/admin/scenes")

      assert html =~ "Listing Scenes"
      assert html =~ scene.name
    end

    test "saves new scene", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/admin/scenes")

      assert index_live |> element("a", "New Scene") |> render_click() =~
               "New Scene"

      assert_patch(index_live, ~p"/admin/scenes/new")

      assert index_live
             |> form("#scene-form", scene: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#scene-form", scene: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/admin/scenes")

      html = render(index_live)
      assert html =~ "Scene created successfully"
      assert html =~ "some name"
    end

    test "updates scene in listing", %{conn: conn, scene: scene} do
      {:ok, index_live, _html} = live(conn, ~p"/admin/scenes")

      assert index_live |> element("#scenes-#{scene.id} a", "Edit") |> render_click() =~
               "Edit Scene"

      assert_patch(index_live, ~p"/admin/scenes/#{scene}/edit")

      assert index_live
             |> form("#scene-form", scene: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#scene-form", scene: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/admin/scenes")

      html = render(index_live)
      assert html =~ "Scene updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes scene in listing", %{conn: conn, scene: scene} do
      {:ok, index_live, _html} = live(conn, ~p"/admin/scenes")

      assert index_live |> element("#scenes-#{scene.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#scenes-#{scene.id}")
    end
  end

  describe "Show" do
    setup [:create_scene]

    test "displays scene", %{conn: conn, scene: scene} do
      {:ok, _show_live, html} = live(conn, ~p"/admin/scenes/#{scene}")

      assert html =~ "Show Scene"
      assert html =~ scene.name
    end

    test "updates scene within modal", %{conn: conn, scene: scene} do
      {:ok, show_live, _html} = live(conn, ~p"/admin/scenes/#{scene}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Scene"

      assert_patch(show_live, ~p"/admin/scenes/#{scene}/show/edit")

      assert show_live
             |> form("#scene-form", scene: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#scene-form", scene: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/admin/scenes/#{scene}")

      html = render(show_live)
      assert html =~ "Scene updated successfully"
      assert html =~ "some updated name"
    end
  end
end
