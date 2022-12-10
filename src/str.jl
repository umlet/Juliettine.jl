module Str


iscomment(s::AbstractString) = isempty(s)  ?  false  :  s[1] == '#'


splitind1(s::AbstractString, i::Int64) = SubString{String}(s, firstindex(s), prevind(s, i))
splitind2(s::AbstractString, i::Int64) = SubString{String}(s, nextind(s,i), lastindex(s))


sw(s::AbstractString) = x -> startswith(x, s)
ew(s::AbstractString) = x -> endswith(x, s)


jn(args...) = join(args...)
jn(c::Char) = X -> jn(X, c)
jn(s::AbstractString) = X -> jn(X, s)


Base.IteratorSize(::Type{Iterators.PartitionIterator{T}}) where {T<:AbstractString} = Base.SizeUnknown()
Base.IteratorEltype(::Type{Iterators.PartitionIterator{T}}) where {T<:AbstractString} = Base.HasEltype()
Base.eltype(::Type{Iterators.PartitionIterator{T}}) where {T<:AbstractString} = SubString{T}
function Base.iterate(itr::Iterators.PartitionIterator{<:AbstractString}, state = firstindex(itr.c))
    state > ncodeunits(itr.c) && return nothing
    lastind = min(nextind(itr.c, state, itr.n - 1), lastindex(itr.c))
    return SubString(itr.c, state, lastind), nextind(itr.c, lastind)
end
eachsplitn(args...) = ipartition(args...)  # alway stays iteratory for long string






include("str.jl_exports")
end # module
