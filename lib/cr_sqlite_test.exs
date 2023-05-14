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

      list = [
        "milk",
        "potatos",
        "avocado",
        "butter",
        "cheese",
        "broccoli",
        "spinach"
      ]

      for {item, idx} <- Enum.with_index(list) do
        Repo.list(conn, ~s|INSERT INTO todo VALUES (?, 'groceries', ?, 0)|, [idx, item])
      end

      res = Repo.list(conn, "select * from todo")

      auto_assert(
        {:ok,
         [
           %{complete: 0, id: 0, list: "groceries", text: "milk"},
           %{complete: 0, id: 1, list: "groceries", text: "potatos"},
           %{complete: 0, id: 2, list: "groceries", text: "avocado"},
           %{complete: 0, id: 3, list: "groceries", text: "butter"},
           %{complete: 0, id: 4, list: "groceries", text: "cheese"},
           %{complete: 0, id: 5, list: "groceries", text: "broccoli"},
           %{complete: 0, id: 6, list: "groceries", text: "spinach"}
         ]} <- res
      )

      {:ok, changes} = Repo.array(conn, ~s|SELECT * FROM crsql_changes where db_version > -1|)

      auto_assert(
        [
          [
            "todo_list",
            "'groceries'",
            "creation_time",
            "'2023-05-14T13:01:06.863028'",
            1,
            1,
            nil
          ],
          ["todo", "0", "complete", "0", 1, 2, nil],
          ["todo", "0", "list", "'groceries'", 1, 2, nil],
          ["todo", "0", "text", "'milk'", 1, 2, nil],
          ["todo", "1", "complete", "0", 1, 3, nil],
          ["todo", "1", "list", "'groceries'", 1, 3, nil],
          ["todo", "1", "text", "'potatos'", 1, 3, nil],
          ["todo", "2", "complete", "0", 1, 4, nil],
          ["todo", "2", "list", "'groceries'", 1, 4, nil],
          ["todo", "2", "text", "'avocado'", 1, 4, nil],
          ["todo", "3", "complete", "0", 1, 5, nil],
          ["todo", "3", "list", "'groceries'", 1, 5, nil],
          ["todo", "3", "text", "'butter'", 1, 5, nil],
          ["todo", "4", "complete", "0", 1, 6, nil],
          ["todo", "4", "list", "'groceries'", 1, 6, nil],
          ["todo", "4", "text", "'cheese'", 1, 6, nil],
          ["todo", "5", "complete", "0", 1, 7, nil],
          ["todo", "5", "list", "'groceries'", 1, 7, nil],
          ["todo", "5", "text", "'broccoli'", 1, 7, nil],
          ["todo", "6", "complete", "0", 1, 8, nil],
          ["todo", "6", "list", "'groceries'", 1, 8, nil],
          ["todo", "6", "text", "'spinach'", 1, 8, nil]
        ] <- changes
      )
    end
  end
end
