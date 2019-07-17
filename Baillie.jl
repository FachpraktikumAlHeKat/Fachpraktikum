#Rekursionsfolgentest
#explizit berechnet

include("power_residue_symbol.jl")

function periodtest(f)

	#Ring fuer a,b (Rekursionsparameter)
#=
	q = 29
	k = ResidueRing(ZZ,q)
	kt,t = k["t"]
=#
	kt = parent(f)
   	q = characteristic(base_ring(kt))

	a = kt(t+1)
	b = kt(1)
	d = 7		#da q=29
	if power_residue(a^2-4*b,f,div(q-1,d))==1
		#return
		error("Diskriminante ...")
	end
#-------------------------------------------------------------
	#Ring fuer Rekursionspolynom
#=
	kts,s = kt["s"]
	rp = kts(s^2-a*s+b)
=#

	#Ring fuer Lucas-Folge
	T = ResidueRing(kt,f)
	S,s = T["s"]
	rp = s^2-a*s+b
	R = ResidueRing(S,rp)

	#Startwerte
	x0 = R(2)
	x1 = R(a)

	u = x0
	v = x1
#-------------------------------------------------------------
	#Periode soll Teiler von n sein (a_n=a_0 und a_(n+1)=a_1)
	n = (q^Int(degree(f)))^2-1
	#n = digits(n, base=2)
	n = base(n,2)
	B = length(n)

	#n-tes und (n+1)-tes Glied der Rekursion explizit berechnet
	#for i=B:-1:1
	for i=1:B
		if n[i]=='1'
			u = u*v-a
			v = v^2-2
		else
			v = u*v-a
			u = u^2-2
		end
	end
	#return u,v
#-------------------------------------------------------------
#Test
#wenn irreduzibel => Periode |n => a_n=a_0 und a_(n+1)=a_1	
	if u==x0&&v==x1
		return true
	else
		return false
	end

end
