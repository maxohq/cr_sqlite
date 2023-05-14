# With ideas from from https://github.com/zeam-vm/cpu_info/blob/master/lib/cpu_info.ex
defmodule CrSqlite.CpuInfo do
  @doc """
  Responds with os type / cpu type tuple.

  Example:
      iex_ > CrSqlite.CpuInfo.fullinfo()
      {:macos, "arm64"}
  """
  @spec fullinfo :: {atom(), binary()}
  def fullinfo do
    if v = CrSqlite.CacheETS.get(:fullinfo) do
      v
    else
      v = {os_type(), cpu_type()}
      CrSqlite.CacheETS.put(:fullinfo, v)
      v
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
