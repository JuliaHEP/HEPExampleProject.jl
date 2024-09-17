using HEPExampleProject
using Test
using SafeTestsets

begin
    @safetestset "four momentum" begin
        include("four_momentum.jl")
    end
    @safetestset "differential cross section" begin
        include("differential_cross_section.jl")
    end
end
