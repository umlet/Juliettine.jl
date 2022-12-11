module Iter


import Base.Iterators
using OrderedCollections


# TODO check Fix1, Fix2..


abstract type PreferredEvaltype end
struct PreferredEvaltypeLazy <: PreferredEvaltype end
struct PreferredEvaltypeEager <: PreferredEvaltype end

PreferredEvaltype(::Type{<:AbstractArray})::PreferredEvaltype = PreferredEvaltypeEager()
PreferredEvaltype(::Type{<:AbstractDict})::PreferredEvaltype = PreferredEvaltypeEager()
PreferredEvaltype(::Type{<:AbstractSet})::PreferredEvaltype = PreferredEvaltypeEager()

PreferredEvaltype(::Type)::PreferredEvaltype = PreferredEvaltypeLazy()  # default

PreferredEvaltype(x)::PreferredEvaltype = PreferredEvaltype(typeof(x))






cl(args...) = collect(args...)

ifilter(args...) =      Iterators.filter(args...)
imap(args...) =         Iterators.map(args...)
itake(args...) =        Iterators.take(args...)
ipartition(args...) =   Iterators.partition(args...)

ifilter(f) =    X -> ifilter(f, X)
imap(f) =       X -> imap(f, X)
itake(n) =      X -> itake(X, n)
ipartition(n) = X -> ipart(X, n)




fl(f::Function, X)                     = ifilter(f, X)
fl(f::Function, X::AbstractVector)     = cl(ifilter(f, X))
fl(f::Function, X::AbstractDict)       = cl(ifilter(f, X))  # Note: Base.filter would keep Dict-icity..
fl(f::Function)                        = X -> fl(f, X)


#mp(f::Function, X)                     = imap(f, X)
#mp(f::Function, X::AbstractVector)     = cl(imap(f, X))
#mp(f::Function, X::AbstractDict)       = cl(imap(f, X))  # Note: Base.filter would keep Dict-icity..
_mp(f::Function, X, ::PreferredEvaltypeLazy) = imap(f, X)
_mp(f::Function, X, ::PreferredEvaltypeEager) = cl(imap(f, X))
mp(f::Function, X) = _mp(f, X, PreferredEvaltype(typeof(X)))
mp(f::Function) = X -> mp(f, X)
# TODO remove ::Function, as constructor is also possible!


tk(X, n::Int64) = itake(X, n)
tk(X::AbstractVector, n::Int64) = cl(itake(X, n))  # or use invoke() on generic tk()
tk(n::Int64)    = X -> tk(X, n)


pt(X, n) = ipartition(X, n)  # not much of a shortcut..
pt(s::AbstractVector, n) = cl(ipartition(X, n))
pt(X::AbstractString, n) = cl(ipartition(X, n))
pt(n::Int64) = x -> pt(x, n)


hd(X, n::Int64=10) = cl(tk(X, n))
hd(n::Int64)  = X -> hd(X, n)


cn(args...) = count(args...)
cn(f::Function) = x -> count(f, x)


is(T::Type) = x -> isa(x, T)
# more elegent than:
#is(T::Type) = Base.Fix2(isa, T)



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




flbyval(fval::Function, d::AbstractDict) = typeof(d)( ifilter(x->fval(x[2]), d) )
flbyval(fval::Function) = X -> flbyval(fval, X)


sortbyval(d::OrderedDict; args...) = sort(d; byvalue=true, args...)


include("iter.jl_exports")
end # module
