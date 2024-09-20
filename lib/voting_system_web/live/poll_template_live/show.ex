defmodule VotingSystemWeb.PollTemplateLive.Show do
  use VotingSystemWeb, :live_view

  alias VotingSystem.Polls

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:poll_template, Polls.get_poll_template!(id))}
  end

  defp page_title(:show), do: "Show Poll template"
  defp page_title(:edit), do: "Edit Poll template"
end
