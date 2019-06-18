#d-th power residue symbol
q =29
#k = GF(q)
k=ResidueRing(ZZ,29)
kx,x = k["x"]
a = x^2+4
include("iteratePolys.jl")
include("power_residue_symbol_factor.jl")

include("iteratePolys.jl")
#b=x^2+2
#symbol=1
#function d_pow_res_sym(a,symbol,q)
Polynome = iteratePolys(q,3,100)

	for d in 1:q
		if mod(q-1,d)==0
			for b in Polynome
			#b=x^3
			print(d)
			if power_residue(a,b,d,1,q)==powmod(a, div( q^degree(b)-1, d ), b)
    				print("gleich \t")
    				print(b, "\t")
    				println(isirreducible(b))
				println(isirreducible(a))
				
			else
    				print("ungleich \t")
    				print(b, "\t")
    				println(isirreducible(b))
				println(isirreducible(a))
			end
		end
	end
end
#end