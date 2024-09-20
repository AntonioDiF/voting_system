defmodule VotingSystemWeb.PollTemplateLiveTest do
  use VotingSystemWeb.ConnCase

  import Phoenix.LiveViewTest
  import VotingSystem.PollsFixtures

  @create_attrs %{options: ["option1", "option2"], question: "some question"}
  @update_attrs %{options: ["option1"], question: "some updated question"}
  @invalid_attrs %{options: [], question: nil}

  defp create_poll_template(_) do
    poll_template = poll_template_fixture()
    %{poll_template: poll_template}
  end

  describe "Index" do
    setup [:create_poll_template, :register_and_log_in_user]

    test "lists all poll_templates", %{conn: conn, poll_template: poll_template} do
      {:ok, _index_live, html} = live(conn, ~p"/poll_templates")

      assert html =~ "Listing Poll templates"
      assert html =~ poll_template.question
    end

    test "saves new poll_template", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/poll_templates")

      assert index_live |> element("a", "New Poll template") |> render_click() =~
               "New Poll template"

      assert_patch(index_live, ~p"/poll_templates/new")

      assert index_live
             |> form("#poll_template-form", poll_template: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#poll_template-form", poll_template: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/poll_templates")

      html = render(index_live)
      assert html =~ "Poll template created successfully"
      assert html =~ "some question"
    end

    test "updates poll_template in listing", %{conn: conn, poll_template: poll_template} do
      {:ok, index_live, _html} = live(conn, ~p"/poll_templates")

      assert index_live
             |> element("#poll_templates-#{poll_template.id} a", "Edit")
             |> render_click() =~
               "Edit Poll template"

      assert_patch(index_live, ~p"/poll_templates/#{poll_template}/edit")

      assert index_live
             |> form("#poll_template-form", poll_template: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#poll_template-form", poll_template: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/poll_templates")

      html = render(index_live)
      assert html =~ "Poll template updated successfully"
      assert html =~ "some updated question"
    end

    test "deletes poll_template in listing", %{conn: conn, poll_template: poll_template} do
      {:ok, index_live, _html} = live(conn, ~p"/poll_templates")

      assert index_live
             |> element("#poll_templates-#{poll_template.id} a", "Delete")
             |> render_click()

      refute has_element?(index_live, "#poll_templates-#{poll_template.id}")
    end
  end

  describe "Show" do
    setup [:create_poll_template, :register_and_log_in_user]

    test "displays poll_template", %{conn: conn, poll_template: poll_template} do
      {:ok, _show_live, html} = live(conn, ~p"/poll_templates/#{poll_template}")

      assert html =~ "Show Poll template"
      assert html =~ poll_template.question
    end

    test "updates poll_template within modal", %{conn: conn, poll_template: poll_template} do
      {:ok, show_live, _html} = live(conn, ~p"/poll_templates/#{poll_template}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Poll template"

      assert_patch(show_live, ~p"/poll_templates/#{poll_template}/show/edit")

      assert show_live
             |> form("#poll_template-form", poll_template: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#poll_template-form", poll_template: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/poll_templates/#{poll_template}")

      html = render(show_live)
      assert html =~ "Poll template updated successfully"
      assert html =~ "some updated question"
    end
  end
end
