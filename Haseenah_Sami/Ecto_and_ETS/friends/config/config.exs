import Config

config :friends, ecto_repos: [Friends.Repo]
config :friends, Friends.Repo,
  database: "friends_repo",
  username: "postgres",
  password: "123456",
  hostname: "localhost",
  port: "5432"
