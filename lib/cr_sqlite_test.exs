defmodule CrSqliteTest do
  use ExUnit.Case
  use MnemeDefaults
    describe "path_for" do
    test "works" do
      CrSqlite.extensions()
      |> Enum.map(fn ext ->
        assert CrSqlite.path_for(ext) |> IO.inspect()
      end)
    end
  end
end