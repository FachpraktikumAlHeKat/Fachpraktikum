# Rekursionsfolgentest
# KLAPPT NOCH NICHT!!!!!

q=29
k=ResidueRing(ZZ,q)
kx,x = k["x"]


function recursionstest(f,q)

# mache dir eine Rekursionsfolge
a=Array{nmod_poly}(undef,q^degree(f)+1)
a[1]= x
a[2]=x+1
a[3]=a[1]+a[2]
for i in 3:q^(degree(f))
if a[i]!= a[2] || a[i-1]!= a[1] 
	a[i+1]= mod(a[i]+a[i-1],f)
	#i=i+1
print(i ,"\n")
else  # sonst a1=ai-1 und a2=ai

	#d=divrem(q^degree(f)-1,i-2)
	#if d[2]==0
	if mod(q^degree(f)-1,i-1)==0	
		return i, a[i], a[1], true
	else return i, a[i], a[1], false
		
	end
end
end
end

	