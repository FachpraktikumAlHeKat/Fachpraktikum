# Rekursionsfolgentest
# KLAPPT NOCH NICHT!!!!!

q=29
k=ResidueRing(ZZ,q)
kx,x = k["x"]


function recursionstest(f,q)

# mache dir eine Rekursionsfolge
a=Array{nmod_poly}(undef,q^degree(f)+3)

a[1]= x
a[2]=x^2+8*x+18
a[3]=mod(a[1]+a[2],f)				# schonmal festlegen, sonst meckert er!
for i in 3:(q^(degree(f)))
if a[i]!= a[2] || a[i-1]!= a[1] 
	a[i+1]= mod(a[i]+a[i-1],f)
print(i ,"\n")
else  # sonst a1=ai-1 und a2=ai

	#d=divrem(q^(degree(f))-1,i-2)		# i-2 ist Periode, wenns ab i-1 wiederholt
	#if d[2]==0
	if mod(q^(degree(f))-1,i-2)==0	
		return i, a[i], a[1], true
	end
		
end
i=k
end
return a[k], a[1], false
# wir haben immer bei i= 16 die rückgabe true- ich verstehe nur nicht warum
end

	