#false => reduzibel, true => ?, irreduzibel => true

#MRpoly4 mit a

#Abwandlung Miller-Rabin-Test fuer Polynome

#include("pExponentiation.jl")


#f^p in F_p

function hochp(f,p)
  erg = 0
  for i in degree(f):-1:0
    erg = erg + (coeff(f,i))^p * x^Int(i*p)
  end
  return erg
end
#-----------------------------------------------------------------------------

#p-adische Exponentiation modulo g

function pexpMod(f,e,g,p)		#fuer f^e mod g in F_p

  if nbits(e) <= 63
    return powmod(f, Int(e), g)
  else

    #p = Int(p)

  #Berechnung e in Basis p
    Exp = e
    Bin = []
    Laenge = 0

    while Exp!=0
      Exp, Rest = divrem(Exp, p)
      push!(Bin, Rest)                #Speicherplatz anders machen?
      Laenge += 1
    end

  #Berechnung Potenzen bis f^(p-1)
    #Potenzen = [0 for i=1:Int(p)]
    #Potenzen = zeros(1,Int(p))
    Potenzen = Array{nmod_poly,1}(undef, Int(p))
    Potenzen[1] = 1*x^0

    for i in 2:Int(p)

      Potenzen[i] = Potenzen[i-1] * f

    end

  #Potenzieren (0 -> quadrieren, 1 -> quadrieren und multiplizieren)
    #Erg = 1
    Erg = Potenzen[Int(Bin[1])+1]
    for i in 2:Laenge
      #Erg = (Erg^p) * (f^(Bin[i]))
      #Erg = mod(Erg, g)

      #Erg = mod(mod((Erg^p), g)*(f^(Bin[i])), g)
      Erg = mod( mod(hochp(Erg,p), g) * (Potenzen[Int(Bin[i])+1]), g)
    end

    return Erg
  end
end
#-----------------------------------------------------------------------------

function Base.rand(Kx::GFPPolyRing, n::Int)
  K = base_ring(Kx)
  return Kx([rand(K) for i=0:n])
end

function Base.rand(Kx::GFPFmpzPolyRing, n::Int)
  K = base_ring(Kx)
  return Kx([rand(K) for i=0:n])
end

function rem!(z::nmod_poly, x::nmod_poly, y::nmod_poly)
  iszero(y) && throw(DivideError())
  ccall((:nmod_poly_rem, :libflint), Nothing,
          (Ref{nmod_poly}, Ref{nmod_poly}, Ref{nmod_poly}), z, x, y)
  return z
end

#-----------------------------------------------------------------------------

function MRpoly4_a(f,a)
	kx = parent(f)
    p = characteristic(base_ring(kx))
	#a = rand(kx, degree(f))

    t = 0                     #Exponent wie in MR
	ord = p^degree(f)-1		    #Ordnung von Einheitengruppe von R (wenn f irred.)
	t, u = remove(ord, 2)

	if degree(gcd(a,f))>0		  #haben a und f gemeinsamen Teiler?
		return false	       	  # => f nicht irreduzibel
	end

#	b = powmod(a,u,f)
#	b = binexpMod2(a,u,f)
    b = pexpMod(a,u,f,p)

	if isone(b)
		return true
	end

	for s in 1:t
		if mod(b,f)==p-1	      #-1===p-1
			return true
		end
		#b = rem!(b,b^2,f)
        b = mod(b^2,f)
	end

	return false
end
