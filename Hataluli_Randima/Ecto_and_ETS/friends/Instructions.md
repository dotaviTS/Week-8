# Ecto

## Steps 

1. create the project
  - mix new friends --sup

2. Add dependencies 

- Add the ecto and postgrex package dependencies to your mix.exs file.

```
defp deps do
    [
      {:ecto_sql, "~> 3.2"},
      {:postgrex, "~> 0.15"}
    ]
  end
```  
3. Create repo 

## Set up a repository by running:

```  
mix ecto.gen.repo -r Friends.Repo
```  

- This will generate the configuration required in config/config.exs to connect to a database including the adapter to use. This is the configuration file for our Friends application

config :friends, Friends.Repo,
  database: "friends_repo",
  username: "postgres",
  password: "",
  hostname: "localhost"