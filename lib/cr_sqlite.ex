defmodule CrSqlite do
  @moduledoc """
  Documentation for `CrSqlite`.
  """
  alias Exqlite.Basic

  def load_extension(conn) do
    Basic.enable_load_extension(conn)
    Basic.load_extension(conn, CrSqlite.Util.path())
  end
end
