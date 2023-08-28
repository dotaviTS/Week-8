defmodule Friends.Repo do
  use Ecto.Repo,
    otp_app: :friends,
    adapter: Ecto.Adapters.Postgres

    def start(_type, _args) do
      # List all child processes to be supervised
      children = [
        Friends.Repo,
      ]
    end
end
