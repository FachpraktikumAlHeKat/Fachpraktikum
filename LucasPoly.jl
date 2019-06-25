# Versuch des Lucas-Test f�r polynome


q=29
k=ResidueRing(ZZ,q)
kx,x = k["x"]

# a random polynom; deg(a) < deg(f)

function LucasPoly(f,a,q)

grad=degree(f)

if mod(a^(q^grad-1),f)==1 
	
	for i in 2:(q^grad-2)		#f�ngt bei 1 an zu z�hlen
println(i)
		if gcd(i, q^grad-1)!=1
			if mod(a^i,f)==1
				return false
			end
		end
	end
return true
else

return false
end
end