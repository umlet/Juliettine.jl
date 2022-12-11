#!/usr/bin/env julia

using Test
using Base.Iterators

using Juliettine

addone(x) = x + 1

@testset "Iter" begin
    @test fl(isodd, [1, 2, 3]) == [1, 3]
    @test [1, 2, 3] |> fl(isodd) == [1, 3]

    @test [0, 1, 2] |> mp(addone) |> fl(isodd) == [1, 3]
    @test [0, 1, 2] |> X -> imap(addone, X) |> fl(isodd) == [1, 3]  # TODO check for IteratorSize, which the map's generator should provide from its source
end

