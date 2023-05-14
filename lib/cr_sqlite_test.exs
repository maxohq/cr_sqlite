defmodule CrSqliteTest do
  use ExUnit.Case
  use MnemeDefaults

  describe "path_for" do
    test "works" do
      list =
        Enum.map(CrSqlite.extensions(), &CrSqlite.path_for/1)
        |> Enum.map(fn x -> String.replace_leading(x, File.cwd!(), "") end)

      #auto_assert(["/_build/test/lib/cr_sqlite/priv/darwin-arm64/crsqlite"] <- list)
    end
  end
end
