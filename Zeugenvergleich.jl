#wegen powmod in PRT_a geht das ab Grad(f)=18 schief, bei p=13

#=
power_residue_test: false => reducible
                    true  => ?
(MR genauso)

Anzahl Pseudoprimzahlen: true + reducible
Anzahl Zeugen: a mit -> false
=#

include("iteratePolys.jl")
include("PRT_a.jl")
include("MRpoly4_a.jl")

function Zeugenvergleich(f,n)
    kx = parent(f)
    p = characteristic(base_ring(kx))
    Polys = iteratePolys(Int(p),100,n)
    count = 0

    for a in Polys
        P = power_residue_test_a(f,a)
        M = MRpoly4_a(f,a)

        if P==true && M==true
            count = count + 1
            #println("a: $a")
        #else
        #    println("a: $a \t PRT: $P \t MRpoly: $M")
        end
    end
    #if !isirreducible(f)
        Prozent = count*100/n
        println("count = $count \t $Prozent %")
    #end
end
