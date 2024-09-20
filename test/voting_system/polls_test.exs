defmodule VotingSystem.PollsTest do
  use VotingSystem.DataCase

  alias VotingSystem.Polls

  describe "poll_templates" do
    alias VotingSystem.Polls.PollTemplate

    import VotingSystem.PollsFixtures

    @invalid_attrs %{options: nil, question: nil}

    test "list_poll_templates/0 returns all poll_templates" do
      poll_template = poll_template_fixture()
      assert Polls.list_poll_templates() == [poll_template]
    end

    test "get_poll_template!/1 returns the poll_template with given id" do
      poll_template = poll_template_fixture()
      assert Polls.get_poll_template!(poll_template.id) == poll_template
    end

    test "create_poll_template/1 with valid data creates a poll_template" do
      valid_attrs = %{options: ["option1", "option2"], question: "some question"}

      assert {:ok, %PollTemplate{} = poll_template} = Polls.create_poll_template(valid_attrs)
      assert poll_template.options == ["option1", "option2"]
      assert poll_template.question == "some question"
    end

    test "create_poll_template/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Polls.create_poll_template(@invalid_attrs)
    end

    test "update_poll_template/2 with valid data updates the poll_template" do
      poll_template = poll_template_fixture()
      update_attrs = %{options: ["option1"], question: "some updated question"}

      assert {:ok, %PollTemplate{} = poll_template} = Polls.update_poll_template(poll_template, update_attrs)
      assert poll_template.options == ["option1"]
      assert poll_template.question == "some updated question"
    end

    test "update_poll_template/2 with invalid data returns error changeset" do
      poll_template = poll_template_fixture()
      assert {:error, %Ecto.Changeset{}} = Polls.update_poll_template(poll_template, @invalid_attrs)
      assert poll_template == Polls.get_poll_template!(poll_template.id)
    end

    test "delete_poll_template/1 deletes the poll_template" do
      poll_template = poll_template_fixture()
      assert {:ok, %PollTemplate{}} = Polls.delete_poll_template(poll_template)
      assert_raise Ecto.NoResultsError, fn -> Polls.get_poll_template!(poll_template.id) end
    end

    test "change_poll_template/1 returns a poll_template changeset" do
      poll_template = poll_template_fixture()
      assert %Ecto.Changeset{} = Polls.change_poll_template(poll_template)
    end
  end
end
