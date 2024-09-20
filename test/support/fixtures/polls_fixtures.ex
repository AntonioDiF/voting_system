defmodule VotingSystem.PollsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `VotingSystem.Polls` context.
  """

  @doc """
  Generate a poll_template.
  """
  def poll_template_fixture(attrs \\ %{}) do
    {:ok, poll_template} =
      attrs
      |> Enum.into(%{
        options: ["option1", "option2"],
        question: "some question"
      })
      |> VotingSystem.Polls.create_poll_template()

    poll_template
  end
end
