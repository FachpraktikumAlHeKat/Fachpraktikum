# Rekursionsfolgentest
# KLAPPT NOCH NICHT!!!!!

q=29
k=ResidueRing(ZZ,q)
kx,x = k["x"]


function recursionstest(f,q)

# mache dir eine Rekursionsfolge
a=Array{nmod_poly}(undef,q^degree(f))
a[1]= x^2+1
a[2]=x^3+7
a[3]=x+5
i=3
for i in 3:(q^degree(f))
if a[i]!= a[1]
	a[i+1]= mod(4*a[i-2]+a[i-1]+a[i],f)
	i=i+1
else 

	d=divrem(q^degree(f)-1, i-1)
	if d[2]==0
		return i, a[i], a[1], true
	else return i, a[i], a[1], false
	end
end
end
end

	
