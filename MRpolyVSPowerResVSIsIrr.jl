# laufzeitenvergleich
include("MRpoly4.jl")
include("power_residue_symbol.jl")
q=3833
k=ResidueRing(ZZ,q)
kx,x = k["x"]
a = x^11+x^22+21*x^2+1
#Polynome = iteratePolys(q,3,100)
b= x^824+x^44+x^27+x^13+3
d=q-1
e=div((q-1),d)

#for b in Polynome
	timepow= @time begin power_residue(a,b,e,q) == powmod(a,div(q^(degree(b)-1),d),b) end
	#timeMR=  @time begin MRpoly4(b,a) end
	timeirredb=  @time begin isirreducible(b) end
	timeirreda= @time begin isirreducible(a) end
# end 
	print(timepow," Powerressym", "\n",timeirredb," isirreducible(b)","\n",timeirreda," isirreducible(a)","\n" )

# power_residue ist für große q und große Grade genau so gut oder besser als isirreducible! MRpoly ist dagegen seeeeeeeeeeehr lahm :)