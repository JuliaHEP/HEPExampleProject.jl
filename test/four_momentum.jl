using HEPExampleProject
using Random

RNG = MersenneTwister(137)

@testset "$ELTYPE1 $ELTYPE2" for (ELTYPE1,ELTYPE2) in Iterators.product((Float64,Float32),(Float64,Float32))
    en1,x1,y1,z1 = rand(RNG,ELTYPE1,4)
    p1 = FourMomentum(en1,x1,y1,z1)

    en2,x2,y2,z2 = rand(RNG,ELTYPE2,4)
    p2 = FourMomentum(en2,x2,y2,z2)

    RESULT_ELTYPE = promote_type(ELTYPE1,ELTYPE2)

    @testset "element types" begin
        @test eltype(p1) == ELTYPE1

        # test promotion on construction
        @test @inferred eltype(FourMomentum(en2,x1,y1,z1)) == RESULT_ELTYPE
        @test @inferred eltype(FourMomentum(en1,x2,y1,z1)) == RESULT_ELTYPE
        @test @inferred eltype(FourMomentum(en1,x1,y2,z1)) == RESULT_ELTYPE
        @test @inferred eltype(FourMomentum(en1,x1,y1,z2)) == RESULT_ELTYPE
    end

    @testset "addition" begin
        p1_plus_p2 = @inferred p1 + p2
        @test eltype(p1_plus_p2)==RESULT_ELTYPE
        @test isapprox(p1_plus_p2.en,en1 + en2)
        @test isapprox(p1_plus_p2.x,x1 + x2)
        @test isapprox(p1_plus_p2.y,y1 + y2)
        @test isapprox(p1_plus_p2.z,z1 + z2)
    end

    @testset "substraction" begin
        p1_minus_p2 = @inferred p1 - p2
        @test isapprox(p1_minus_p2.en,en1 - en2)
        @test isapprox(p1_minus_p2.x,x1 - x2)
        @test isapprox(p1_minus_p2.y,y1 - y2)
        @test isapprox(p1_minus_p2.z,z1 - z2)
    end

    @testset "scalar multiplication" begin
        a = rand(RNG)
        a_times_p1 = @inferred a*p1
        @test isapprox(a_times_p1.en,a*en1)
        @test isapprox(a_times_p1.x,a*x1)
        @test isapprox(a_times_p1.y,a*y1)
        @test isapprox(a_times_p1.z,a*z1)
    end
    
    @testset "minkowski dot" begin
        p1_times_p2 = @inferred minkowski_dot(p1,p2)
        @test isapprox(p1_times_p2,minkowski_dot(p2,p1))
        @test isapprox(p1_times_p2,en1*en2 - x1*x2 - y1*y2 - z1*z2)
    end

    @testset "coords to dict" begin
        E = 1e4*rand(RNG,ELTYPE1)
        cos_theta = 2*rand(RNG,ELTYPE1) - 1
        phi = 2*pi*rand(RNG,ELTYPE1)

        mom_dict = coords_to_dict(E,cos_theta,phi) 
        mom_electron  = mom_dict["e-"]
        mom_positron  = mom_dict["e+"]
        mom_muon      = mom_dict["mu-"]
        mom_anti_muon = mom_dict["mu+"]

        # test CMS for in-channel
        @test isapprox(mom_electron + mom_positron, FourMomentum(2*E, zeros(ELTYPE1,3)...))

        # test CMS for out-channel
        @test isapprox(mom_muon + mom_anti_muon, FourMomentum(2*E, zeros(ELTYPE1,3)...)) 

        # test energy-momentum conservation
        @test isapprox(mom_electron + mom_positron,mom_muon + mom_anti_muon,)
    end
end
