defmodule VotingSystemWeb.PollTemplateLive.Index do
  use VotingSystemWeb, :live_view

  alias VotingSystem.Polls
  alias VotingSystem.Polls.PollTemplate

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :poll_templates, Polls.list_poll_templates())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Poll template")
    |> assign(:poll_template, Polls.get_poll_template!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Poll template")
    |> assign(:poll_template, %PollTemplate{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Poll templates")
    |> assign(:poll_template, nil)
  end

  @impl true
  def handle_info({VotingSystemWeb.PollTemplateLive.FormComponent, {:saved, poll_template}}, socket) do
    {:noreply, stream_insert(socket, :poll_templates, poll_template)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    poll_template = Polls.get_poll_template!(id)
    {:ok, _} = Polls.delete_poll_template(poll_template)

    {:noreply, stream_delete(socket, :poll_templates, poll_template)}
  end
end
