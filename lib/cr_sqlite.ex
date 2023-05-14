defmodule CrSqlite do
  @moduledoc """
  Documentation for `CrSqlite`.
  """

  alias CrSqlite.CpuInfo

  # https://github.com/mindreframer/sqlean/blob/forked/gen/generateMakefile.js#L4
  @extensions CrSqlite.Extensions.all()
  def extensions do
    @extensions
  end

  def path_for(extension) when extension in @extensions do
    Path.join(:code.priv_dir(:ex_litedb), "#{arch_path()}/#{extension}")
  end

  def path_for(missing_ext) do
    raise(
      "Extension '#{missing_ext}' not available! Please pick one from #{inspect(@extensions)}."
    )
  end

  def arch_path() do
    case CpuInfo.fullinfo() do
      {:macos, "arm64"} -> "darwin-arm64"
      {:macos, "amd64"} -> "darwin-amd64"
      {:windows, "win32"} -> "windows-win32"
      {:windows, _} -> "windows-amd64"
      {:linux, _} -> "linux-amd64"
    end
  end
end
