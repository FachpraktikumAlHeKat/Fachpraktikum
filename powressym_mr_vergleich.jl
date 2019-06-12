q=13
k=ResidueRing(ZZ,q)
kx,x=PolynomialRing(k,"x")

f=x^4+5*x^3+3*x+9
include("iteratePolys.jl")
include("power_residue_symbol_fact.jl")
include("MRpoly4.jl")
d=q-1
Polynome=iteratePolys(q,1,13)

for b in Polynome
  res=power_residue(b,f,d,1,q)
  print(isirreducible(f),"\t")

  print(b,"\t")
  print(MRpoly4(f,b),"\t")
  if res==0
  println("0 ")
    continue
    elseif res==powmod(b,div(q^degree(f)-1,d),f)
        println("gleich \t")
    else
      println("anders \t")

    end
end


#f=x^4+5*x^3+3*x+9:
# das residue symbol liegt falsch =>> mrpoly liegt falsch:
#zb b=x^2+5*x+3

 #mrpoly false, res gleich
 # b=x^5+x^2+7*x+1
#b=x^2+7*x+7
