FROM ubuntu:22.04

# Avoid prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    build-essential \
    autoconf \
    automake \
    libtool \
    openjdk-21-jdk \
    && rm -rf /var/lib/apt/lists/*

# Install Julia directly (not juliaup)
ENV JULIA_VERSION=1.12.4
RUN curl -fsSL "https://julialang-s3.julialang.org/bin/linux/x64/1.12/julia-${JULIA_VERSION}-linux-x86_64.tar.gz" | tar -xz -C /opt && \
    ln -s /opt/julia-${JULIA_VERSION}/bin/julia /usr/local/bin/julia
ENV PATH="/opt/julia-${JULIA_VERSION}/bin:${PATH}"

# Cache bust for git clones (use: docker build --build-arg CACHEBUST=$(date +%s) ...)
ARG CACHEBUST=1

# Clone OM.jl without submodules
RUN git clone --branch modprod2026 https://github.com/JKRT/OM.jl.git /opt/OM.jl

# Clone each submodule manually with HTTPS (modprod2026 where available)
WORKDIR /opt/OM.jl
RUN git clone --branch modprod2026 https://github.com/OpenModelica/MetaModelica.jl.git MetaModelica.jl || \
    git clone https://github.com/OpenModelica/MetaModelica.jl.git MetaModelica.jl
RUN git clone https://github.com/OpenModelica/ImmutableList.jl.git ImmutableList.jl
RUN git clone https://github.com/OpenModelica/Absyn.jl.git Absyn.jl
RUN git clone --branch master https://github.com/OpenModelica/OMParser.jl.git OMParser.jl
RUN git clone --branch modprod2026 https://github.com/JKRT/OMFrontend.jl.git OMFrontend.jl
RUN git clone --branch modprod2026 https://github.com/JKRT/OMBackend.jl.git OMBackend.jl
RUN git clone https://github.com/JKRT/ArrayUtil.jl.git ArrayUtil.jl || true
RUN git clone https://github.com/JKRT/ListUtil.jl.git ListUtil.jl || true
RUN git clone https://github.com/JKRT/DAE.jl.git DAE.jl || true
RUN git clone https://github.com/OpenModelica/SCode.jl.git SCode.jl || true
RUN git clone --branch master https://github.com/OpenModelica/OMRuntimeExternalC.jl.git OMRuntimeExternalC.jl

# Add julia-config.jl to PATH
RUN ln -s /opt/julia-${JULIA_VERSION}/share/julia/julia-config.jl /usr/local/bin/julia-config.jl

# Build the parser
WORKDIR /opt/OM.jl/OMParser.jl/lib/parser
RUN autoconf && ./configure && make

# Set up Julia environment with ALL local OM packages (globally)
WORKDIR /opt/tutorial

RUN julia -e ' \
    using Pkg; \
    Pkg.Registry.add("General"); \
    # Develop OM packages globally (default environment) \
    Pkg.develop(path="/opt/OM.jl/ImmutableList.jl"); \
    Pkg.develop(path="/opt/OM.jl/MetaModelica.jl"); \
    Pkg.develop(path="/opt/OM.jl/Absyn.jl"); \
    Pkg.develop(path="/opt/OM.jl/SCode.jl"); \
    Pkg.develop(path="/opt/OM.jl/DAE.jl"); \
    Pkg.develop(path="/opt/OM.jl/ArrayUtil.jl"); \
    Pkg.develop(path="/opt/OM.jl/ListUtil.jl"); \
    Pkg.develop(path="/opt/OM.jl/OMParser.jl"); \
    Pkg.develop(path="/opt/OM.jl/OMRuntimeExternalC.jl"); \
    Pkg.develop(path="/opt/OM.jl/OMFrontend.jl"); \
    Pkg.develop(path="/opt/OM.jl/OMBackend.jl"); \
    Pkg.develop(path="/opt/OM.jl"); \
    # Add other packages globally \
    Pkg.add(["IJulia", "DifferentialEquations", "Plots", "ForwardDiff", "OrdinaryDiffEq"]); \
    Pkg.instantiate(); \
    '

# Final setup
WORKDIR /workspaces/TutorialOMJL_CodeSpace

CMD ["bash"]
