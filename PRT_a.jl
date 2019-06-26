#power residue test mit a


function Base.rand(Kx::NmodPolyRing, n::Int)
  K = base_ring(Kx)
  return Kx([rand(K) for i=0:n])
end

function Base.rand(Kx::GFPPolyRing, n::Int)
  K = base_ring(Kx)
  return Kx([rand(K) for i=0:n])
end

include("power_residue_symbol.jl")

##############################################################################
#testet auf Irreduzibilitaet durch Verwendung von dth power residue symbols
#(und Reziprozitaetsgesetz)
# -> Solovay-Strassen

function power_residue_test_a(f,a)
    kx = parent(f)
    q = characteristic(base_ring(kx))
    #a = rand(kx, degree(f)-1)
    deg = degree(f)

    d = 3
    while mod(q-1,d)!=0                 #moeglichst zufaelliger Teiler
        d = rand(GF(q))
    end

    if gcd(a,f)!=1                      #offensichtlich nicht irreduzibel
        return false
    end

    #b = a^div( (q^Int(deg)-1), d )
    b = powmod(a, div( (q^Int(deg)-1), d ), f)

#=
    if b!=1 && b!=f-1
        return false
    end
=#

    J = power_residue( a, f, div(q-1,d) )

    if J!=b                                #f irreduzibel => J=b
        return false
    end

    return true                         #vielleicht irreduzibel
end
