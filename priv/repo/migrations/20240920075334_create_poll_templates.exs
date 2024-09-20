defmodule VotingSystem.Repo.Migrations.CreatePollTemplates do
  @moduledoc """
  Auto-generated migration for Poll Templates

  Command used: mix phx.gen.live Polls PollTemplate poll_templates question:string options:array:string
  """
  use Ecto.Migration

  def change do
    create table(:poll_templates, :log_in_user) do
      add :question, :string
      add :options, {:array, :string}

      timestamps(type: :utc_datetime)
    end
  end
end
