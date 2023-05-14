defmodule CrSqlite.Repo do
  alias Exqlite.Basic
  alias CrSqlite.Transformer

  def exec(conn, sql, args \\ []) do
    res = Basic.exec(conn, sql, args)

    case res do
      {:ok, _q, result, _conn} -> {:ok, result}
      {:error, error, _conn} -> {:error, error}
    end
  end

  def list(conn, sql, args \\ []) do
    exec(conn, sql, args) |> Transformer.to_list()
  end

  def single(conn, sql, args \\ []) do
    exec(conn, sql, args) |> Transformer.to_single()
  end

  def list_many(conn, list) do
    for item <- list do
      case item do
        [sql, args] -> list(conn, sql, args)
        [sql] -> list(conn, sql)
        sql -> list(conn, sql)
      end
    end
  end
end
