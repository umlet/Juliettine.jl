module Piper

# TODO check Fix1, Fix2..
# TODO traits for iterable, inRAMalready(=Dict, Set, OrdDict, Array)

import Base.Iterators

# TODO check if slurping has lower precedence than single arguments
ifilter(args...) = Iterators.filter(args...)
itake(args...) = Iterators.take(args...)
imap(args...) = Iterators.map(args...)
ipartition(args...) = Iterators.partition(args...)


cl(args...) = collect(args...)


tk(X, n::Int64) = itake(X, n)
tk(X::AbstractVector, n::Int64) = cl(itake(X, n))  # or use invoke() on generic tk()
tk(n::Int64)    = X -> tk(X, n)


hd(X, n::Int64=10) = cl(tk(X, n))
hd(n::Int64)  = X -> hd(X, n)


fl(f::Function, X)                     = ifilter(f, X)
fl(f::Function, X::AbstractVector)     = cl(ifilter(f, X))
fl(f::Function, X::AbstractDict)       = cl(ifilter(f, X))  # Note: Base.filter would keep Dict-icity..
fl(f::Function)                        = X -> fl(f, X)


mp(f::Function, X)                     = imap(f, X)
mp(f::Function, X::AbstractVector)     = cl(imap(f, X))
mp(f::Function, X::AbstractDict)       = cl(imap(f, X))  # Note: Base.filter would keep Dict-icity..
mp(f::Function)                        = X -> mp(f, X)


cn(args...) = count(args...)
cn(f::Function) = x -> count(f, x)


pt(X, n) = ipartition(X, n)  # not much of a shortcut..
pt(s::AbstractVector, n) = cl(ipartition(X, n))
pt(X::AbstractString, n) = cl(ipartition(X, n))
pt(n::Int64) = x -> pt(x, n)


#is(T::Type) = x -> isa(x, T)
is(T::Type) = Base.Fix2(isa, T)



# file extension:
# original logic:
#   file.txt    -> ".txt"
#   file        -> ""
#   .file       -> ""
#   .           -> ""
#   file.       -> "."
# new logic:
#   file.txt    -> "txt"
#   file        -> nothing
#   .file       -> nothing
#   .           -> nothing
#   file.       -> ""
function ext(s)
    _,e = splitext(s)
    e == ""  &&  return nothing
    @assert startswith(e, '.')
    return chop(e; head=1, tail=0)
end




include("piper.jl_exports")
end # module
