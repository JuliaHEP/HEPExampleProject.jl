using HEPExampleProject
using Random

RNG = MersenneTwister(137)

TEST_ENERGY = 1e4*rand(RNG)
TEST_COS_THETA = 2*rand(RNG) - 1
TEST_PHI = 2*pi*rand(RNG)

MOMS_DICT = coords_to_dict(TEST_ENERGY,TEST_COS_THETA,TEST_PHI)
MOM_ELECTRON = MOMS_DICT["e-"]
MOM_POSITRON = MOMS_DICT["e+"]
MOM_MUON      = MOMS_DICT["mu-"]
MOM_ANTI_MUON = MOMS_DICT["mu+"]

WEIGHT = rand(RNG)

@testset "construction" begin
    event_from_mom = Event(MOM_ELECTRON,MOM_POSITRON,MOM_MUON,MOM_ANTI_MUON,WEIGHT)
    event_from_dict = Event(MOMS_DICT,WEIGHT)
    event_from_coords = Event(TEST_ENERGY,TEST_COS_THETA,TEST_PHI,WEIGHT)

    @test event_from_mom == event_from_dict
    @test event_from_mom == event_from_coords
end

@testset "input verification" begin
    invalid_weight = -rand(RNG)
    @test_throws ArgumentError Event(MOM_ELECTRON,MOM_POSITRON,MOM_MUON,MOM_ANTI_MUON,invalid_weight)
    @test_throws ArgumentError Event(MOMS_DICT,invalid_weight)
    @test_throws ArgumentError Event(TEST_ENERGY,TEST_COS_THETA,TEST_PHI,invalid_weight)
end

@testset "accessor" begin
    event = Event(MOMS_DICT,WEIGHT)
    @test isapprox(muon_cos_theta(event),TEST_COS_THETA)
end
