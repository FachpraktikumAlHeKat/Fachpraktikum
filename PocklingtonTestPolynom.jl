#Pocklington Primzahltest fuer Polynome
# -> Irreduzibilitaetstest

function Base.rand(Kx::NmodPolyRing, n::Int)
  K = base_ring(Kx)
  return Kx([rand(K) for i=0:n])
end

function Base.rand(Kx::GFPPolyRing, n::Int)
  K = base_ring(Kx)
  return Kx([rand(K) for i=0:n])
end

#=
function Base.rand(Kx::GFPFmpzPolyRing, n::Int)
  K = base_ring(Kx)
  return Kx([rand(K) for i=0:n])
end
=#

function rem!(z::nmod_poly, x::nmod_poly, y::nmod_poly)	# nmod_poly
  iszero(y) && throw(DivideError())
  ccall((:nmod_poly_rem, :libflint), Nothing,
          (Ref{nmod_poly}, Ref{nmod_poly}, Ref{nmod_poly}), z, x, y)
  return z
end


#-----------------------------------------------------------------------------
function binexpMod2(f,e,g)
  if nbits(e) <= 63
    return powmod(f, Int(e), g)
  else

	#Berechnung e in Binaerzah
	Bin=base(fmpz(e),2)
	Laenge=length(Bin)

	#Potenzieren
    Erg=f
    for i in 2:Laenge
      Erg=mul!(Erg,Erg,Erg)
      if Bin[i]==1
        Erg=mul!(Erg,f,Erg)
      end
	Erg=rem!(Erg,Erg,g)
    end
    return Erg

  end
end


function hoch(a,b)
  if b==0
    return 1
  else
    return a*hoch(a,b-1)
  end
end


#------------------------------------------------------------------------------

#= Fermattest: a^(q^d-1)=1 (mod f)
   p prime, p|q^d-1, p>q^(d/2)-1
   gcd(a^((q^d-1)/p)-1,f)=1
=#
# f = 2*x^7+x^2+x+1 in Z/3 -> true

function PockPoly(f)

  kx = parent(f)
  q = characteristic(base_ring(kx))
  a = rand(kx, degree(f)-1)	         # degree(f) besser als vorher zu speichern
  d = degree(f)

#println(a)

  #if mod(a^(q^d-1),f)!=1
  #if powmod(a,Int(q^d)-1,f)!=1
  if binexpMod2(a,q^d-1,f)!=1
    return false
  end

  #for p in ceil(Int, sqrt(q^d)):div(q^d-1, 2)     #floor((q^d-1)/2)
  for p in q^(ceil(Int, d/2)):2:div(q^d-1, 2)
#println(p)
    if mod(q^d-1,p)!=0
      continue
    end
    if !isprime(p)                          #Primzahltest!
      continue
    end
  #println(p)
    #if gcd(a^(div((q^d-1),p))-1,f)==1
    if gcd(hoch(a,(div((q^d-1),p)))-1,f)==1
      return true
    end
  end

  print("?")
  return 0
end
