defmodule VotingSystem.Polls.PollTemplate do
  use Ecto.Schema
  import Ecto.Changeset

  schema "poll_templates" do
    field :options, {:array, :string}
    field :question, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(poll_template, attrs) do
    poll_template
    |> cast(attrs, [:question, :options])
    |> validate_required([:question, :options])
  end
end
