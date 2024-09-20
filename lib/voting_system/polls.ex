defmodule VotingSystem.Polls do
  @moduledoc """
  The Polls context.
  """

  import Ecto.Query, warn: false
  alias VotingSystem.Repo

  alias VotingSystem.Polls.PollTemplate

  @doc """
  Returns the list of poll_templates.

  ## Examples

      iex> list_poll_templates()
      [%PollTemplate{}, ...]

  """
  def list_poll_templates do
    Repo.all(PollTemplate)
  end

  @doc """
  Gets a single poll_template.

  Raises `Ecto.NoResultsError` if the Poll template does not exist.

  ## Examples

      iex> get_poll_template!(123)
      %PollTemplate{}

      iex> get_poll_template!(456)
      ** (Ecto.NoResultsError)

  """
  def get_poll_template!(id), do: Repo.get!(PollTemplate, id)

  @doc """
  Creates a poll_template.

  ## Examples

      iex> create_poll_template(%{field: value})
      {:ok, %PollTemplate{}}

      iex> create_poll_template(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_poll_template(attrs \\ %{}) do
    %PollTemplate{}
    |> PollTemplate.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a poll_template.

  ## Examples

      iex> update_poll_template(poll_template, %{field: new_value})
      {:ok, %PollTemplate{}}

      iex> update_poll_template(poll_template, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_poll_template(%PollTemplate{} = poll_template, attrs) do
    poll_template
    |> PollTemplate.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a poll_template.

  ## Examples

      iex> delete_poll_template(poll_template)
      {:ok, %PollTemplate{}}

      iex> delete_poll_template(poll_template)
      {:error, %Ecto.Changeset{}}

  """
  def delete_poll_template(%PollTemplate{} = poll_template) do
    Repo.delete(poll_template)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking poll_template changes.

  ## Examples

      iex> change_poll_template(poll_template)
      %Ecto.Changeset{data: %PollTemplate{}}

  """
  def change_poll_template(%PollTemplate{} = poll_template, attrs \\ %{}) do
    PollTemplate.changeset(poll_template, attrs)
  end
end
