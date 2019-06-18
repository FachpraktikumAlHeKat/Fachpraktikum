#d-th power residue symbol
q =13
#k = GF(q)
#kx,x = k["x"]
k=ResidueRing(ZZ,q)
kx,x=PolynomialRing(k,"x")


# ungleiche ergebnisse für a= x^2+3 und b= x^7 bzw b=x^7+1



a = x^2+3 # x^2+4 ist gleich falsch bei beiden 
include("iteratePolys.jl")
include("power_residue_symbol_factor.jl")
include("MRpoly4.jl")
d=q-1
Polynome = iteratePolys(q,4,10)	# Problem: bei x^2 und x^2+2 geben sowohl rabin, als auch resi true aus. 
for b in Polynome
		if power_residue(b,a,d,1,q)==powmod(b, div( q^degree(a)-1, d ), a)
    				print("gleich \t")
    				print(b, "\t")
    				println(isirreducible(b))
				println(isirreducible(a))
				println(MRpoly4(a,b))
			else
    				print("ungleich \t")
    				print(b, "\t")
    				println(isirreducible(b))
				println(isirreducible(a))
				println(MRpoly4(a,b))
			end
end