# Julia development environment

This directory contains a Julia project environments `cpu` and `cuda`
that can be used when developing HEPExampleProject with Julia >= v1.11.
It contains all direct, test and doc-gen dependencies of HEPExampleProject,
plus BenchmarkTools and Cthulhu and JLD2 (for benchmarking and debugging).

Note: This environment can't be used with Julia versions <= v1.10, as it
use a `[sources]` section in the `Project.toml` to ensure HEPExampleProject
is loaded from the local source directory, this Pkg feature was introduced
in Julia v1.11.
