defmodule VotingSystemWeb.PollTemplateLive.FormComponent do
  use VotingSystemWeb, :live_component

  alias VotingSystem.Polls

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage poll_template records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="poll_template-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:question]} type="text" label="Question" />
        <.input
          field={@form[:options]}
          type="select"
          multiple
          label="Options"
          options={[{"Option 1", "option1"}, {"Option 2", "option2"}]}
        />
        <:actions>
          <.button phx-disable-with="Saving...">Save Poll template</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{poll_template: poll_template} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Polls.change_poll_template(poll_template))
     end)}
  end

  @impl true
  def handle_event("validate", %{"poll_template" => poll_template_params}, socket) do
    changeset = Polls.change_poll_template(socket.assigns.poll_template, poll_template_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"poll_template" => poll_template_params}, socket) do
    save_poll_template(socket, socket.assigns.action, poll_template_params)
  end

  defp save_poll_template(socket, :edit, poll_template_params) do
    case Polls.update_poll_template(socket.assigns.poll_template, poll_template_params) do
      {:ok, poll_template} ->
        notify_parent({:saved, poll_template})

        {:noreply,
         socket
         |> put_flash(:info, "Poll template updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_poll_template(socket, :new, poll_template_params) do
    case Polls.create_poll_template(poll_template_params) do
      {:ok, poll_template} ->
        notify_parent({:saved, poll_template})

        {:noreply,
         socket
         |> put_flash(:info, "Poll template created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
