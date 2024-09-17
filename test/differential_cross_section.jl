using HEPExampleProject
using Random
using QuadGK

RNG = MersenneTwister(137)

ENERGIES = (2*MUON_MASS,1e3,1e6) 
COSTHETAS = (-1,1,0,rand(RNG),-rand(RNG))

# from Schartz 2014, eq. 13.75
function groundtruth_diffCS(E,cth)
    ALPHA^2/(16*E^6)*(sqrt(E^2-MUON_MASS^2)/sqrt(E^2 - ELECTRON_MASS^2))*(E^4 + (E^2 - ELECTRON_MASS^2)*(E^2 - MUON_MASS^2)*cth^2 + E^2*(ELECTRON_MASS^2 + MUON_MASS^2))
end

# numerically integrate the diff. cross section
function groundtruth_totCS(E)
    res,_ = quadgk(x -> groundtruth_diffCS(E,x),-1,1) 
    return 2*pi*res
end

@testset "differential cross section" begin
    @testset "E = $E, cth = $cth" for (E,cth) in Iterators.product(ENERGIES, COSTHETAS)
        @test isapprox(differential_cross_section(E,cth),groundtruth_diffCS(E,cth))
    end
end

@testset "total cross section" begin
    @testset "E = $E" for E in ENERGIES
        @test isapprox(total_cross_section(E),groundtruth_totCS(E))
    end
end
