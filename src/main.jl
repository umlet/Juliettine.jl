module AttoMain


export @ifrun, @main


"""
    @ifrun <...>

Guard for scripts, an alias for the usual:
```
if abspath(PROGRAM__FILE) == @__FILE__
    <...>
end
```
Hint: Can be combined with `AttoError`'s `errortame` and your script's main function:
```
@ifrun errortame(main)
```
"""
macro ifrun(argexpr)
    FILE = string(__source__.file)
    expr = quote
        abspath(PROGRAM_FILE) == $(FILE)  &&  $(esc(argexpr))
    end
    #println(expr)
    return expr
end


"""
    @main

Guard for scripts, calling (your own) `main` function wrapped in `AttoError`'s `errortame`.
(Requires "using" package `AttoError` beforehand.)

Shortcut for:
```
@ifrun errortame(main)
```
"""
macro main()
    FILE = string(__source__.file)
    expr = quote
        abspath(PROGRAM_FILE) == $(FILE)  &&  $(esc(:(errortame(main))))
    end
    #println(expr)
    return expr
end


end # module
