defmodule VotingSystem.Repo do
  use Ecto.Repo,
    otp_app: :voting_system,
    adapter: Ecto.Adapters.Postgres
end
