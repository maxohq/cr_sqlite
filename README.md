# CrSqlite

[![CI](https://github.com/maxohq/cr_sqlite/actions/workflows/ci.yml/badge.svg?style=flat)](https://github.com/maxohq/cr_sqlite/actions/workflows/ci.yml)
[![Hex.pm](https://img.shields.io/hexpm/v/cr_sqlite.svg?style=flat)](https://hex.pm/packages/cr_sqlite)
[![Hex Docs](https://img.shields.io/badge/hex-docs-lightgreen.svg?style=flat)](https://hexdocs.pm/cr_sqlite/)
[![Total Downloads](https://img.shields.io/hexpm/dt/cr_sqlite.svg?style=flat)](https://hex.pm/packages/cr_sqlite)
[![Licence](https://img.shields.io/hexpm/l/cr_sqlite.svg?style=flat)](https://github.com/maxohq/cr_sqlite/blob/main/LICENCE)

`CrSqlite` is ...

## Usage

```elixir
alias Exqlite.Basic
{:ok, conn} = Basic.open("db.sqlite3")
CrSqlite.load_extension(conn)

```

## Installation

The package can be installed by adding `cr_sqlite` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:cr_sqlite, "~> 0.1"}
  ]
end
```

The docs can be found at <https://hexdocs.pm/cr_sqlite>.

## License

The lib is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
