#!/usr/bin/env bash

# crsqlite-darwin-aarch64.dylib
# crsqlite-darwin-x86_64.dylib
# crsqlite-linux-aarch64.so
# crsqlite-linux-x86_64.so
# crsqlite-windows-x86_64.dll
# https://github.com/vlcn-io/cr-sqlite/releases/download/v0.10.1/crsqlite-darwin-aarch64.dylib

export VERSION="v0.10.1"

mkdir -p priv/darwin-arm64
pushd priv/darwin-arm64
rm *
wget "https://github.com/vlcn-io/cr-sqlite/releases/download/$VERSION/crsqlite-darwin-aarch64.dylib" -O crsqlite.dylib
popd


mkdir -p priv/darwin-amd64
pushd priv/darwin-amd64
rm *
wget "https://github.com/vlcn-io/cr-sqlite/releases/download/$VERSION/crsqlite-darwin-x86_64.dylib" -O crsqlite.dylib
popd


mkdir -p priv/windows-amd64
pushd priv/windows-amd64
rm *
wget "https://github.com/vlcn-io/cr-sqlite/releases/download/$VERSION/crsqlite-windows-x86_64.dll" -O crsqlite.dll
popd


mkdir -p priv/linux-amd64
pushd priv/linux-amd64
rm *
wget "https://github.com/vlcn-io/cr-sqlite/releases/download/$VERSION/crsqlite-linux-x86_64.so" -O crsqlite.so
popd


mkdir -p priv/linux-arm64
pushd priv/linux-arm64
rm *
wget "https://github.com/vlcn-io/cr-sqlite/releases/download/$VERSION/crsqlite-linux-aarch64.so" -O crsqlite.so
popd
