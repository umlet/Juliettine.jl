module Juliettine

# zero deps
include("error.jl")
using .Error
include("error.jl_exports")

include("str.jl")
using .Str
include("str.jl_exports")

include("piper.jl")
using .Piper
include("piper.jl_exports")


include("conv.jl")  # dep on Str, Piper
using .Conv
include("conv.jl_exports")

include("inout.jl")  # dep on Str, Piper
using .InOut
include("inout.jl_exports")

end # module Romeo
