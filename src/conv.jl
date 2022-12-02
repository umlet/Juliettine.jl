module Conv


import Printf: format, Format


using ..Piper
using ..Str


toint(x) = parse(Int64, x)
tofloat(x) = parse(Float64, x)


tostr(x::Integer) = string(x)

function tostr´(i::Int64, sep=",")
    s = i |> abs |> string |> reverse |> pt(3) |> jn(',') |> reverse
    sign(i) == -1  &&  return "-" * s
    return s
end

tostr(x::AbstractFloat) = format(Format("%.6g"), x)

tostr1(x::AbstractFloat) = format(Format("%.1f"), x)
tostr2(x::AbstractFloat) = format(Format("%.2f"), x)
tostr3(x::AbstractFloat) = format(Format("%.3f"), x)
tostr4(x::AbstractFloat) = format(Format("%.4f"), x)
tostr5(x::AbstractFloat) = format(Format("%.5f"), x)
tostr6(x::AbstractFloat) = format(Format("%.6f"), x)
tostr7(x::AbstractFloat) = format(Format("%.7f"), x)
tostr8(x::AbstractFloat) = format(Format("%.8f"), x)

tostrf(fmt::AbstractString, x) = format(Format(fmt), x)


function fsizehuman(x::Int64)
    RET = Base.format_bytes(x)
    RET = replace(RET, "i" => "")
    RET = replace(RET, "B" => "b")
    return RET
end


isint(x) = tryparse(Int64, x) !== nothing
isfloat(x) = tryparse(Float64, x) !== nothing


trytoint(x) = tryparse(Int64, x)
trytofloat(x) = tryparse(Float64, x)




include("conv.jl_exports")
end # module