defmodule CrSqlite.Util do
  def path do
    Path.join(:code.priv_dir(:cr_sqlite), "#{CrSqlite.CpuInfo.arch_path()}/crsqlite")
  end
end