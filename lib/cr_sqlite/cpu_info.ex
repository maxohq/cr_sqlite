# With ideas from from https://github.com/zeam-vm/cpu_info/blob/master/lib/cpu_info.ex
defmodule CrSqlite.CpuInfo do
  @cache_key :cr_sqlite_cpu_info

  @doc """
  Responds with os type / cpu type tuple.

  Example:
      iex_ > CrSqlite.CpuInfo.fullinfo()
      {:macos, "arm64"}
  """
  @spec fullinfo :: {atom(), binary()}
  def fullinfo do
    if v = :persistent_term.get(@cache_key, nil) do
      v
    else
      v = {os_type(), cpu_type()}
      :persistent_term.put(@cache_key, v)
      v
    end
  end

  def arch_path() do
    case fullinfo() do
      {:macos, "arm64"} -> "darwin-arm64"
      {:macos, "amd64"} -> "darwin-amd64"
      {:linux, "arm64"} -> "linux-arm64"
      {:linux, "amd64"} -> "linux-amd64"
      {:windows, "win32"} -> "windows-win32"
      {:windows, _} -> "windows-amd64"
    end
  end

  defp cpu_type do
    cpu_type_sub(os_type())
  end

  defp cpu_type_sub(os_type) when os_type in [:windows, :linux, :unknown] do
    :erlang.system_info(:system_architecture) |> List.to_string() |> String.split("-") |> hd
  end

  defp cpu_type_sub(os_type) when os_type in [:freebsd, :macos] do
    confirm_executable("uname")

    case System.cmd("uname", ["-m"]) do
      {result, 0} -> result |> String.trim()
      _ -> raise RuntimeError, message: "uname does not work."
    end
  end

  defp confirm_executable(command) do
    if is_nil(System.find_executable(command)) do
      raise RuntimeError, message: "#{command} isn't found."
    end
  end

  defp os_type do
    case :os.type() do
      {:unix, :linux} -> :linux
      {:unix, :darwin} -> :macos
      {:unix, :freebsd} -> :freebsd
      {:win32, _} -> :windows
      _ -> :unknown
    end
  end
end
