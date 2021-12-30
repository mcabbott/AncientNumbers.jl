using AncientNumbers
using Test, LinearAlgebra
using Documenter, Aqua

@show ARGS

@testset "AncientNumbers" begin
    @testset "basics" begin

        @test I + II === III  # LinearAlgebra.I
        
        @test 𒐕 + II + ䷂ == 𒐚

    end
    if VERSION > v"1.6-"
        @testset "doctests" begin

            doctest(AncientNumbers, manual=false)

        end
    end
    @testset "Aqua" begin

        Aqua.test_all(AncientNumbers)

    end
end