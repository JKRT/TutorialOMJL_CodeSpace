# OMJL Tutorial - MODPROD 2026

Interactive tutorial for OpenModelica.jl (OMJL).

## Quick Start

### Option 1: GitHub Codespaces (Recommended for beginners)
Click the button below to open in Codespaces:

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/JKRT/TutorialOMJL_CodeSpace)

After setup completes, start Pluto:
```bash
julia --project=. -e 'using Pluto; Pluto.run(host="0.0.0.0")'
```

### Option 2: Local Installation
1. Install Julia 1.12+
2. Clone this repo
3. Run:
```bash
julia --project=. -e 'using Pkg; Pkg.instantiate()'
julia --project=. -e 'using Pluto; Pluto.run()'
```

## Tutorial Contents

1. **Modelica Basics** - Introduction to Modelica modeling
2. **Julia-Modelica Integration** - Using Modelica with Julia scripting
3. **Language Extensions** - Extending Modelica with OMJL

## Notebooks

- `notebooks/01_modelica_basics.jl` - Part 1
- `notebooks/02_julia_modelica.jl` - Part 2
- `notebooks/03_language_extensions.jl` - Part 3
