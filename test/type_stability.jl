using HEPExampleProject
using Random

RNG = Xoshiro(137)
TYPES = (Float32, Float64)
ENERGIES = (2*MUON_MASS,1e3,1e6) 
COSTHETAS = (-1,1,0,rand(RNG),-rand(RNG))

@testset "$val_type" for val_type in TYPES

    test_energies  = convert.(val_type,ENERGIES)
    @test all(@. typeof(test_energies) == val_type)
    test_costhetas = convert.(val_type,COSTHETAS)
    @test all(@. typeof(test_costhetas) == val_type)

    @testset "E = $E" for E in test_energies

        @testset "cth = $cth" for cth in test_costhetas

            @testset "differential_cross_section" begin
                diff_cs = @inferred differential_cross_section(E,cth) 
                @test typeof(diff_cs) == val_type
            end

        end

        @testset "total cross section" begin
            tot_cs = @inferred total_cross_section(E) 
            @test typeof(tot_cs) == val_type
        end

    end
end
