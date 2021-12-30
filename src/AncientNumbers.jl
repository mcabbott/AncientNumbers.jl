"""
# AncientNumbers.jl

```
julia> using AncientNumbers

julia> XV + 𒐝  - ䷀
𒎙𒐗

julia> ans + XXXVII
𒐕
```
Constructors are [`babylon`](@ref), [`rome`](@ref), [`persia`](@ref), [`iching`](@ref).
"""
module AncientNumbers

export rome, persia, babylon, iching

abstract type AncientCount <: Integer end  # not really necessary

"""
    babylon(n)

Returns a number in Babylonian cuneiform. This is base-60, but they
didn't have a real zero, so you need context to know what's going on:

```jldoctest; setup=:(using AncientNumbers, Dates)
julia> babylon(1), babylon(60)
(𒐕, 𒐕)

julia> ans .+ 2
(𒐗, 𒐕𒐖)

julia> ans == (𒐕, 𒐕) .+ 𒐖
false

julia> reshape(𒐕:𒐕𒐕-𒐕, (𒐙 , 𒌋𒐖)) |> collect
5×12 Matrix{AncientNumbers.Babylonian}:
 𒐕  𒐚  𒌋𒐕  𒌋𒐚  𒎙𒐕  𒎙𒐚  𒌍𒐕  𒌍𒐚  𒐏𒐕  𒐏𒐚  𒐔𒐕  𒐔𒐚
 𒐖  𒐛  𒌋𒐖  𒌋𒐛  𒎙𒐖  𒎙𒐛  𒌍𒐖  𒌍𒐛  𒐏𒐖  𒐏𒐛  𒐔𒐖  𒐔𒐛
 𒐗  𒐜  𒌋𒐗  𒌋𒐜  𒎙𒐗  𒎙𒐜  𒌍𒐗  𒌍𒐜  𒐏𒐗  𒐏𒐜  𒐔𒐗  𒐔𒐜
 𒐘  𒐝  𒌋𒐘  𒌋𒐝  𒎙𒐘  𒎙𒐝  𒌍𒐘  𒌍𒐝  𒐏𒐘  𒐏𒐝  𒐔𒐘  𒐔𒐝
 𒐙  𒌋  𒌋𒐙   𒎙  𒎙𒐙   𒌍  𒌍𒐙   𒐏  𒐏𒐙   𒐔  𒐔𒐙   𒐕

julia> using Dates; babylon(year(today()))
𒌍𒐗𒐏𒐕   # babylon(2021)

julia> digits(ans, base=60) |> reverse |> Tuple
(33, 41)

julia> babylon(61), babylon(60^2 + 1), babylon(60^3 + 60), babylon(60^3 + 1)
(𒐕𒐕, 𒐕_𒐕, 𒐕_𒐕, 𒐕__𒐕)
```
It seems that they left some space for a missing middle digit,
written `𒐕_𒐕` here. Later they invented a character for this purpose,
but unicode doesn't have it.

They also used base 60 for fractions, with no decimal point,
so that `1//60` is written `𒐕`. But this package does not
support that.

See also [`persia`](@ref), [`rome`](@ref), [`iching`](@ref).
"""
babylon(n::Integer) = n>0 ? Babylonian(n) : throw(DomainError(n, 
    "Babylonians didn't write zero, or negative numbers!"))
    # This check is on the exported function, so that the constructor
    # can permit negative numbers internally, e.g. in range calculations.

@doc @doc(babylon)
struct Babylonian <: AncientCount
    n::Int
    # The inner constructor here avoids some ambiguities:
    Babylonian(n::Integer) = new(n)
end

"""
    persia(n)

Returns a number in Old Persian cuneiform,
using five symbols whose values are simply added:

```jldoctest; setup=:(using AncientNumbers, Dates)
julia> persia.((1, 2, 10, 20, 100))
(𐏑, 𐏒, 𐏓, 𐏔, 𐏕)

julia> persia.((13, 42, 101))
(𐏓𐏒𐏑, 𐏔𐏔𐏒, 𐏕𐏑)

julia> 𐏕 - 𐏑
𐏔𐏔𐏔𐏔𐏓𐏒𐏒𐏒𐏒𐏑   # persia(99)

julia> using Dates; persia(year(today()))
𐏕𐏕𐏕𐏕𐏕𐏕𐏕𐏕𐏕𐏕𐏕𐏕𐏕𐏕𐏕𐏕𐏕𐏕𐏕𐏕𐏔𐏑  # but this is not attested.
```

Apparently we have no examples of numbers larger than `120 == 𐏕𐏔`,
so how they handled those isn't known. This package extrapolates.

See also [`babylon`](@ref), [`rome`](@ref), [`iching`](@ref).
"""
persia(n::Integer) = n>0 ? Persian(n) : throw(DomainError(n, 
    "Persians didn't write zero, or negative numbers!"))

@doc @doc(persia)
struct Persian <: AncientCount
    n::Int
    Persian(n::Integer) = new(n)
end

"""
    iching(n)

Returns the `n`-th hexagram of the I Ching.

```jldoctest; setup=:(using AncientNumbers)
julia> iching.((1, 2, 3))
(䷀, ䷁, ䷂)

julia> sum(ans)
䷅   # iching(6)

julia> reshape(䷀:䷿, (䷇, ䷇)) |> collect
8×8 Matrix{AncientNumbers.IChingHexagram}:
 ䷀  ䷈  ䷐  ䷘  ䷠  ䷨  ䷰  ䷸
 ䷁  ䷉  ䷑  ䷙  ䷡  ䷩  ䷱  ䷹
 ䷂  ䷊  ䷒  ䷚  ䷢  ䷪  ䷲  ䷺
 ䷃  ䷋  ䷓  ䷛  ䷣  ䷫  ䷳  ䷻
 ䷄  ䷌  ䷔  ䷜  ䷤  ䷬  ䷴  ䷼
 ䷅  ䷍  ䷕  ䷝  ䷥  ䷭  ䷵  ䷽
 ䷆  ䷎  ䷖  ䷞  ䷦  ䷮  ䷶  ䷾
 ䷇  ䷏  ䷗  ䷟  ䷧  ䷯  ䷷  ䷿

julia> ans[䷁, ䷁ + ䷀]
䷑   # iching(18)

julia> 𒎙𒐙 == ䷘ == XXV
true
```
See also [`babylon`](@ref), [`persia`](@ref), [`rome`](@ref).
"""
iching(n::Integer) = 0<n<65 ? IChingHexagram(n) : throw(DomainError(n, 
    "The I Ching only has hexagrams 1 to 64"))

@doc @doc(iching)
struct IChingHexagram <: AncientCount
    n::Int
    IChingHexagram(n::Integer) = new(n)
end

"""
    rome(n)

Returns a number in Roman numerals, written in 
ordinary Latin (ASCII) letters.

Follows the rule that one subtraction, by the next lowest
power-of-10 value, is allowed, and is required.

```jldoctest; setup=:(using AncientNumbers; using AncientNumbers: Roman; using Dates)
julia> collect(I:XII)'
1×12 adjoint(::Vector{Roman}) with eltype Roman:
 I  II  III  IV  V  VI  VII  VIII  IX  X  XI  XII

julia> rome.((1, 5, 10, 50, 100, 500, 1000))
(I, V, X, L, C, D, M)

julia> rome(49)
XLIX

julia> ans == L - I == 𒐏𒐝
true

julia> IL  # only X can be subtracted from L
ERROR: UndefVarError: IL not defined

julia> MCMLXXXIV + XX
MMIV

julia> MMXX - MMXXI
II (B.C.)
```
(Unicode has special symbols for these, `'Ⅰ' .+ (0:XV)`, but they don't
seem to display at a reasonable size nor spacing.)

Of course, nobody used these for the intermediate steps of calculations, 
since they lived a little while before scrap paper & ballpoint pens were common.
This library, too, uses technology more convenient than a chisel to perform addition.

See also [`babylon`](@ref), [`persia`](@ref), [`iching`](@ref).
"""
rome(n::Integer) = n>0 ? Roman(n) : throw(DomainError(n, 
    "Romans didn't write zero, or negative numbers!"))

@doc @doc(rome)
struct Roman <: AncientCount
    n::Int
    Roman(n::Integer) = new(n)
end

#####
##### arithmetic
#####

TYPES = [Babylonian, Persian, Roman, IChingHexagram]

for i in eachindex(TYPES)
    for j in i:length(TYPES)
        # The different types must know of each other, to break ties.
        T1, T2 = TYPES[i], TYPES[j]
        @eval Base.promote_rule(::Type{$T1}, ::Type{$T2}) = $T1
    end
end

for Count in TYPES

    # @eval Base.promote_rule(::Type{$Count}, ::Type{T}) where {T<:Integer} = $Count
    @eval Base.promote_rule(::Type{$Count}, ::Type{T}) where {T<:Union{Int,Int32,Bool}} = $Count
    @eval Base.promote_rule(::Type{$Count}, ::Type{T}) where {T<:Number} = T
    
    for op in [:*, :+, :-, :div, :rem]  # binary, re-wrap
        @eval Base.$op(x::$Count, y::$Count) = $Count($op(x.n, y.n))
    end

    for op in [:abs, :abs2, :-]  # unary, re-wrap
        @eval Base.$op(x::$Count) = $Count($op(x.n))
    end

    for op in [:<, :<=, :(==)]  # binary, unwrap
        @eval Base.$op(x::$Count, y::$Count) = $op(x.n, y.n)
    end

    for op in [:Int, :Int32, :AbstractFloat]  # unary, unrap
        @eval Base.$op(x::$Count) = $op(x.n)
    end

end

using LinearAlgebra

rome(u::UniformScaling) = rome(I.λ)
Roman(u::UniformScaling) = Roman(I.λ)

(::Colon)(u::UniformScaling, n::Roman) = u.λ:n
(::Colon)(u::UniformScaling, s::UniformScaling, n::Roman) = u.λ:rome(s.λ):n
(::Colon)(u::UniformScaling, s::Roman, n::Roman) = u.λ:s:n

#####
##### printing
#####

function Base.show(io::IO, c::Babylonian)
    if c <= 0
        return print(io, "Babylonian(", c.n, ")")
    end
    digs = reverse(digits(c.n, base = 60))
    # They didn't distinguish 1 from 60 from 3600, 
    # so delete trailing 0s from modern base-60 representation:
    while !isempty(digs) && last(digs) == 0
        pop!(digs)
    end
    _tenchars(x) = x==0 ? "" : ('𒐕' + x-1)
    for x in digs
        if x == 0
            # They didn't have a zero, but did sometimes leave a bigger gap
            # betweeh the 60^2 and 60^0 digits...
            print(io, '_')
            # Later they invented a symbol for this, but unicode doesn't have it?
            # print(io, "𒀹𒀹") # Not quite right, 𒃵 𒍦 𒍞 𒍭 𒋰  are all wrong
        else
            str = x == 0 ? ' ' :
                  x < 10 ? _tenchars(x)  :
                  x < 50 ? ('𒌋', '𒎙', '𒌍', '𒐏', 'z')[x÷10] * _tenchars(x%10) :
                           ('𒐏' + x÷10) * _tenchars(x%10)
            print(io, str)
        end
    end
end
function Base.show(io::IO, ::MIME"text/plain", c::Babylonian)
    show(io, c)
    get(io, :typeinfo, nothing) === nothing || return
    if c > 0
        printstyled(io, "   # babylon(", c.n, ")", color=:light_black)
    else
        printstyled(io, "  # but this wasn't invented yet!", color=:light_black)
    end
end
Base.string(c::Babylonian; base::Integer = 60, pad::Integer = 1) = 
    base == 60 ? sprint(show, c) : string(c.n; base, pad)

function Base.show(io::IO, c::Persian)
    x = Int(c)
    if x <= 0
        return print(io, "Persian(", c.n, ")")
    end
    print(io, '𐏕'^(x ÷ 100))
    x = x % 100
    print(io, '𐏔'^(x ÷ 20))
    x = x % 20
    print(io, '𐏓'^(x ÷ 10))
    x = x % 10
    print(io, '𐏒'^(x ÷ 2))
    x = x % 2
    print(io, '𐏑'^x)
end
function Base.show(io::IO, ::MIME"text/plain", c::Persian)
    show(io, c)
    get(io, :typeinfo, nothing) === nothing || return
    if 0 < c < 256
        printstyled(io, "   # persia(", c.n, ")", color=:light_black)
    elseif c <= 0
        printstyled(io, "  # but this wasn't invented yet!", color=:light_black)
    else
        # The largest attested number is in fact 120, according to
        # https://en.wikipedia.org/wiki/Old_Persian_cuneiform
        printstyled(io, "  # but this is not attested.", color=:light_black)
    end
end
Base.string(c::Persian; base::Integer = 20, pad::Integer = 1) = 
    base == 20 ? sprint(show, c) : string(c.n; base, pad)

function Base.show(io::IO, c::IChingHexagram)
    x = Int(c)
    if x<1 || x>64
        return print(io, "IChingHexagram(", c.n, ")")
    end
    print(io, '䷀' + x-1)
end
function Base.show(io::IO, ::MIME"text/plain", c::IChingHexagram)
    show(io, c)
    get(io, :typeinfo, nothing) === nothing || return
    if 0 < c < 65
        printstyled(io, "   # iching(", c.n, ")", color=:light_black)
    else
        printstyled(io, "  # but there is no such hexagram!", color=:light_black)
    end
end
Base.string(c::IChingHexagram; base::Integer = 64, pad::Integer = 1) = 
    base == 64 ? sprint(show, c) : string(c.n; base, pad)

const ROMANS = [
    (1000, "M")
    (900,  "CM")
    (500,  "D")
    (400,  "CD")
    (100,  "C")
    (90,   "XC")
    (50,   "L")
    (40,   "XL")
    (10,   "X")
    (9,    "IX")
    (5,    "V")
    (4,    "IV")
    (1,    "I")
]  # from https://github.com/anthonyclays/RomanNumerals.jl/blob/master/src/roman_conversion.jl

function Base.show(io::IO, c::Roman)
    x = Int(c)
    if x > 5 * ROMANS[1][1]
        return print(io, "Roman(", x, ")")
    elseif x <= 0
        show(io, Roman(1-x)) # there was no year 0
        return print(io, " (B.C.)")
    end
    for (val, str) in ROMANS
        n = x ÷ val
        if n != 0
            print(io, str^n)
            x -= n * val
        end
    end
end
Base.string(c::Roman; base::Integer = 1000, pad::Integer = 1) = 
    base == 1000 ? sprint(show, c) : string(c.n; base, pad)

#####
##### exports
#####

# These take precompilation time 0.76 -> 1.34 seconds,
# but seem to have no effect on loading time after that.

for n in 1:1000
    sy = Symbol(string(Babylonian(n)))
    isdefined(@__MODULE__, sy) && continue  # else 60 overwrites 1
    @eval const $sy = Babylonian($n)
    @eval export $sy
end

for n in 1:120
    sy = Symbol(string(Persian(n)))
    @eval const $sy = Persian($n)
    @eval export $sy
end

for n in 1:64
    sy = Symbol(string(IChingHexagram(n)))
    @eval const $sy = IChingHexagram($n)
    @eval export $sy
end

for n in 2:2100
    sy = Symbol(string(Roman(n)))
    @eval const $sy = Roman($n)
    n>1 && @eval export $sy
end

export I  # from LinearAlgebra

#####
##### parsing
#####

# What RomanNumerals.jl did was to allow `parse(Roman, "MCM")` and a string macro `rn"MCM"`.
# That would allow arbitrarily large numbers, and non-standard ones like VIIII,
# and Mayan numbers whose unicode characters aren't valid identifiers...

end # module
