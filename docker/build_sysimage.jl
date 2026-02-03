using PackageCompiler

# Packages to include in sysimage
packages = [
    :Pluto,
    :OMFrontend,
    :OMBackend,
]

# Precompile statements (optional - speeds up specific operations)
precompile_file = joinpath(@__DIR__, "precompile_statements.jl")

create_sysimage(
    packages;
    sysimage_path = joinpath(@__DIR__, "..", "sysimage", "tutorial.so"),
    precompile_statements_file = isfile(precompile_file) ? precompile_file : nothing,
)
