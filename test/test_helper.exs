ExUnit.start

Mix.Task.run "ecto.create", ~w(-r Colors.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r Colors.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(Colors.Repo)

