defmodule CrSqlite.Application do
  @moduledoc false
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      CrSqlite.CacheETS
    ]
    opts = [strategy: :one_for_one, name: CrSqlite.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
