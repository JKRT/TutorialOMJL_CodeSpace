#!/bin/bash
set -e

echo "=== Installing Julia ==="
curl -fsSL https://install.julialang.org | sh -s -- -y
export PATH="$HOME/.juliaup/bin:$PATH"

# Symlink for VS Code extension
sudo ln -sf "$HOME/.juliaup/bin/julia" /usr/local/bin/julia

echo "=== Installing build tools ==="
sudo apt-get update
sudo apt-get install -y autoconf automake libtool build-essential

echo "=== Cloning OM.jl (modprod2026 branch) ==="
git clone --depth 1 --branch modprod2026 https://github.com/JKRT/OM.jl.git /tmp/OM.jl

echo "=== Building parser ==="
cd /tmp/OM.jl/OMParser.jl/lib/parser
autoconf
./configure
make

echo "=== Setting up Julia environment ==="
cd /workspaces/TutorialOMJL_CodeSpace

julia --project=. -e '
using Pkg
Pkg.Registry.add("General")
Pkg.Registry.add(Pkg.RegistrySpec(url="https://github.com/JKRT/OpenModelicaRegistry.git"))
Pkg.add(["Pluto"])
Pkg.develop(path="/tmp/OM.jl/OMFrontend.jl")
Pkg.develop(path="/tmp/OM.jl/OMBackend.jl")
Pkg.instantiate()
Pkg.build()
'

echo "=== Setup complete ==="
echo "To start Pluto, run:"
echo "  julia --project=. -e 'using Pluto; Pluto.run(host=\"0.0.0.0\")'"
