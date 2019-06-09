#systematisch die Polynome in F_p[x] durchgehen
#p -> Charakteristik, d -> ab Grad = d, n -> Anzahl der Polynome

function iteratePolys(p,d,n)

  k = GF(p)
  #k = ResidueRing(ZZ,p)
  kx, x = k["x"]
  Polys = Array{gfp_poly,1}(undef, n)
  #Polys = Array{nmod_poly,1}(undef, n)

  for i in p^d:p^d+n-1
    p_adic = digits(i, base=p)
    Polys[i-p^d+1] = kx(p_adic)
  end

#=
open("Polynome.txt","w") do file
write(file, "$Polys")
end
=#

  return Polys

end
