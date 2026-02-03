# OMJL Tutorial - MODPROD 2026

Interactive tutorial for OpenModelica.jl (OMJL) - a Julia-based Modelica compiler.

# How to run docker locally if you do not get the Jupyter notebook to run
docker run -it ghcr.io/jkrt/omjl-tutorial:latest
Then you can execute using OM and reuse the same commands that are specified in the notebook. 
Simply copy and paste.

Note you need to run git clone to get access to models locally 
```
git clone https://github.com/JKRT/TutorialOMJL_CodeSpace.git
```
#NOTE 
```
julia> using OM
┌ OMRuntimeExternalC
│  ┌ Error: Could not find the ModelicaStandardTables library
│  └ @ OMRuntimeExternalC /opt/OM.jl/OMRuntimeExternalC.jl/src/pathSetup.jl:17
│  ┌ Error: omc runtime not found
│  └ @ OMRuntimeExternalC /opt/OM.jl/OMRuntimeExternalC.jl/src/pathSetup.jl:31
│  ┌ Error: omc sim runtime not found
│  └ @ OMRuntimeExternalC /opt/OM.jl/OMRuntimeExternalC.jl/src/pathSetup.jl:42
│  ┌ Error: omc runtime for I/O not found
│  └ @ OMRuntimeExternalC /opt/OM.jl/OMRuntimeExternalC.jl/src/pathSetup.jl:53
│  ┌ Error: omc runtime for external C not found
│  └ @ OMRuntimeExternalC /opt/OM.jl/OMRuntimeExternalC.jl/src/pathSetup.jl:64
└  
┌ OM
│  [Output was shown above]
```
The code above is not really an error message!

#Command to pull Docker 
docker pull ghcr.io/jkrt/omjl-tutorial:latest  <img width="768" height="88" alt="image" src="https://github.com/user-attachments/assets/6f7a7acc-e4a5-4aaf-9b82-1d40dffdebe5" />


## Quick Start

### Option 1: GitHub Codespaces (Recommended)

Click the button below to open in Codespaces:

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/JKRT/TutorialOMJL_CodeSpace)

After setup completes, start Jupyter:
```bash
julia -e 'using IJulia; notebook(dir="notebooks")'
```

Then open `OMJL_Tutorial.ipynb` in the browser.

### Option 2: Docker (Pre-built Environment)

Run the tutorial in a Docker container with everything pre-installed:

```bash
# Pull and run interactively

docker run -it -p 8888:8888 -v $(pwd):/workspaces/TutorialOMJL_CodeSpace ghcr.io/jkrt/omjl-tutorial:latest

# Or build locally
git clone https://github.com/JKRT/TutorialOMJL_CodeSpace.git
cd TutorialOMJL_CodeSpace
docker build -t omjl-tutorial -f docker/Dockerfile .
docker run -it -p 8888:8888 -v $(pwd):/workspaces/TutorialOMJL_CodeSpace omjl-tutorial
```

Inside the container, start Jupyter:
```bash
julia -e 'using IJulia; notebook(dir="/workspaces/TutorialOMJL_CodeSpace/notebooks", host="0.0.0.0")'
```

Then open `http://localhost:8888` in your browser.

### Option 3: Local Installation

#### Prerequisites

1. **Julia 1.12+** - Download from [julialang.org](https://julialang.org/downloads/)
2. **Java 21+** - Only required if building the parser manually (not needed with prebuilt binaries)

#### Install OMJL

Clone the OMJL repository with all submodules:

```bash
git clone --branch modprod2026 --recurse-submodules https://github.com/JKRT/OM.jl.git
cd OM.jl
```

**Parser setup:**

Prebuilt binaries are available for most platforms, so building is usually not necessary. The parser will be downloaded automatically when you first use OMParser.

If you need to build manually (Linux/macOS):
```bash
cd OMParser.jl/lib/parser
autoconf && ./configure && make
cd ../../..
```

Set up Julia packages (run from the OM.jl directory):
```bash
julia -e '
using Pkg
Pkg.develop(path="ImmutableList.jl")
Pkg.develop(path="MetaModelica.jl")
Pkg.develop(path="Absyn.jl")
Pkg.develop(path="SCode.jl")
Pkg.develop(path="DAE.jl")
Pkg.develop(path="ArrayUtil.jl")
Pkg.develop(path="ListUtil.jl")
Pkg.develop(path="OMParser.jl")
Pkg.develop(path="OMRuntimeExternalC.jl")
Pkg.develop(path="OMFrontend.jl")
Pkg.develop(path="OMBackend.jl")
Pkg.develop(path=".")
'
```

#### Install Tutorial Dependencies

```bash
julia -e 'using Pkg; Pkg.add(["IJulia", "DifferentialEquations", "Plots", "ForwardDiff", "OrdinaryDiffEq"])'
```

#### Test the Installation

Verify that OMJL is working correctly:

```bash
julia -e '
using OM
using OMFrontend
using OMBackend
println("OMJL packages loaded successfully!")
'
```

You can also run a quick simulation test:

```julia
using OM, DifferentialEquations

# Simple test model
model = """
model Test
  Real x(start = 1.0);
equation
  der(x) = -x;
end Test;
"""

# Write to temp file and simulate
path = tempname() * ".mo"
write(path, model)
sol = OM.simulate("Test", path; stopTime = 5.0)
println("Simulation successful! Final x = ", sol[:x][end])
```

#### Run the Tutorial

Clone this repository and start Jupyter:

```bash
git clone https://github.com/JKRT/TutorialOMJL_CodeSpace.git
cd TutorialOMJL_CodeSpace
julia -e 'using IJulia; notebook(dir="notebooks")'
```

Open `OMJL_Tutorial.ipynb` in the browser.

## Tutorial Contents

1. **Part 1: Modelica Basics** - Variables, parameters, equations, hybrid systems
2. **Part 2: Julia-Modelica Integration** - Parameter studies, sensitivity analysis, ML integration
3. **Part 3: Language Extensions** - Variable-structure systems, structural modes, dynamic recompilation

## Resources

- [OMJL GitHub](https://github.com/JKRT/OM.jl)
- [OpenModelica](https://openmodelica.org/)
- [Modelica Standard Library Documentation](https://doc.modelica.org/Modelica%204.0.0/Resources/helpDymola/Modelica.html)
- [DifferentialEquations.jl Documentation](https://docs.sciml.ai/)

## TL;DR

**Fastest option:** Use GitHub Codespaces (click the badge at the top) or Docker.

**Docker one-liner:**
```bash
docker run -it -p 8888:8888 ghcr.io/jkrt/omjl-tutorial:latest
```

### Manual Installation Script

Copy and run this Julia script to clone and set up OMJL automatically:

```julia
using Pkg

omjl_path = joinpath(homedir(), "OM.jl")
if !isdir(omjl_path)
    mkdir(omjl_path)
end
cd(omjl_path)

# Clone packages with correct branches
# modprod2026 branch
run(`git clone --branch modprod2026 https://github.com/JKRT/OM.jl.git $omjl_path/OM.jl`)
run(`git clone --branch modprod2026 https://github.com/OpenModelica/MetaModelica.jl.git $omjl_path/MetaModelica.jl`)
run(`git clone --branch master https://github.com/OpenModelica/OMParser.jl.git $omjl_path/OMParser.jl`)
run(`git clone --branch modprod2026 https://github.com/JKRT/OMFrontend.jl.git $omjl_path/OMFrontend.jl`)
run(`git clone --branch modprod2026 https://github.com/JKRT/OMBackend.jl.git $omjl_path/OMBackend.jl`)

# Default branch (master/main)
run(`git clone https://github.com/OpenModelica/ImmutableList.jl.git $omjl_path/ImmutableList.jl`)
run(`git clone https://github.com/OpenModelica/Absyn.jl.git $omjl_path/Absyn.jl`)
run(`git clone https://github.com/OpenModelica/SCode.jl.git $omjl_path/SCode.jl`)
run(`git clone https://github.com/JKRT/DAE.jl.git $omjl_path/DAE.jl`)
run(`git clone https://github.com/JKRT/ArrayUtil.jl.git $omjl_path/ArrayUtil.jl`)
run(`git clone https://github.com/JKRT/ListUtil.jl.git $omjl_path/ListUtil.jl`)
run(`git clone --branch master https://github.com/OpenModelica/OMRuntimeExternalC.jl.git $omjl_path/OMRuntimeExternalC.jl`)

# Develop packages in dependency order
Pkg.develop(path="$omjl_path/ImmutableList.jl")
Pkg.develop(path="$omjl_path/MetaModelica.jl")
Pkg.develop(path="$omjl_path/Absyn.jl")
Pkg.develop(path="$omjl_path/SCode.jl")
Pkg.develop(path="$omjl_path/DAE.jl")
Pkg.develop(path="$omjl_path/ArrayUtil.jl")
Pkg.develop(path="$omjl_path/ListUtil.jl")
Pkg.develop(path="$omjl_path/OMParser.jl")
Pkg.develop(path="$omjl_path/OMRuntimeExternalC.jl")
Pkg.develop(path="$omjl_path/OMFrontend.jl")
Pkg.develop(path="$omjl_path/OMBackend.jl")
Pkg.develop(path="$omjl_path/OM.jl")

# Add tutorial dependencies
Pkg.add(["IJulia", "DifferentialEquations", "Plots", "ForwardDiff", "OrdinaryDiffEq"])

Pkg.instantiate()
Pkg.build()

println("OMJL installed successfully at: $omjl_path")
```

---
*Tutorial created for MODPROD 2026*
