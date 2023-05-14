defmodule CrSqliteTest do
  use ExUnit.Case
  use MnemeDefaults
  alias CrSqlite.Repo

  describe "full run" do
    test "works" do
      alias Exqlite.Basic
      {:ok, conn} = Basic.open(":memory:")
      CrSqlite.load_extension(conn)

      setup = [
        ~s|CREATE TABLE IF NOT EXISTS todo_list ("name" primary key, "creation_time")|,
        ~s|CREATE TABLE IF NOT EXISTS todo ("id" primary key, "list", "text", "complete")|,
        ~s|SELECT crsql_as_crr('todo_list')|,
        ~s|SELECT crsql_as_crr('todo')|,
        [
          ~s|INSERT OR IGNORE INTO todo_list VALUES ('groceries', ?)|,
          ["2023-05-14T13:01:06.863028"]
        ],
        "select * from todo_list"
      ]

      res = Repo.list_many(conn, setup)

      auto_assert(
        [
          ok: [],
          ok: [],
          ok: [%{"crsql_as_crr('todo_list')": nil}],
          ok: [%{"crsql_as_crr('todo')": nil}],
          ok: [],
          ok: [%{creation_time: "2023-05-14T13:01:06.863028", name: "groceries"}]
        ] <- res
      )
    end
  end
end
