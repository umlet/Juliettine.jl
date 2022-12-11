module Juliettine

# zero deps
include("error.jl")
using .Error
include("error.jl_exports")

include("str.jl")
using .Str
include("str.jl_exports")

include("iter.jl")
using .Iter
include("iter.jl_exports")



include("group.jl")  # dep on Iter
using .Group
include("group.jl_exports")



include("conv.jl")  # dep on Str, Iter
using .Conv
include("conv.jl_exports")

include("inout.jl")  # dep on Str, Iter
using .InOut
include("inout.jl_exports")

end # module Romeo
