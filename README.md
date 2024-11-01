# AncientNumbers.jl

```julia
julia> using Pkg; Pkg.add(url="https://github.com/mcabbott/AncientNumbers.jl")

julia> using AncientNumbers

julia> XV + 𒐝  - ䷀
𒎙𒐗

julia> ans + XXXVII
𒐕

julia> [f(n) for f in (babylon, rome, persia, iching), n in 𒐕:LXIV]
4×64 Matrix{AncientNumbers.AncientCount}:
 𒐕   𒐖    𒐗   𒐘    𒐙    𒐚     𒐛     𒐜  …    𒐕    𒐕𒐕    𒐕𒐖     𒐕𒐗     𒐕𒐘
 I  II  III  IV    V   VI   VII  VIII      LX   LXI  LXII  LXIII   LXIV
 𐏑   𐏒   𐏒𐏑  𐏒𐏒  𐏒𐏒𐏑  𐏒𐏒𐏒  𐏒𐏒𐏒𐏑  𐏒𐏒𐏒𐏒     𐏔𐏔𐏔  𐏔𐏔𐏔𐏑  𐏔𐏔𐏔𐏒  𐏔𐏔𐏔𐏒𐏑  𐏔𐏔𐏔𐏒𐏒
 ䷀   ䷁    ䷂   ䷃    ䷄    ䷅     ䷆     ䷇       ䷻     ䷼     ䷽      ䷾      ䷿

julia> sum(ans)
𒐖𒌋𒐜𒐏   # babylon(8320)
```
