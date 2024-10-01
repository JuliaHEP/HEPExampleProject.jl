using HEPExampleProject
using Test
using SafeTestsets

begin
    @safetestset "four momentum" begin
        include("four_momentum.jl")
    end
    @safetestset "cross section" begin
        include("differential_cross_section.jl")
    end
    @safetestset "events" begin
        include("events.jl")
    end
    @safetestset "type stability" begin
        include("type_stability.jl")
    end
end
