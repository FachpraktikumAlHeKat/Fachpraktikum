#Binaere Exponentiation modulo g

function binexpMod2(f,e,g)

  if nbits(e) <= 63
    return powmod(f, Int(e), g)
  else
    
#Berechnung e in Binaerzahl
#=
    Exp = e
    Bin = []
    Laenge = 0

    while Exp!=0
      Exp, Rest = divrem(Exp, 2)
      push!(Bin, Rest)
      Laenge += 1
    end
=#

    Bin = base(fmpz(e),2)
    Laenge = length(Bin)

#Potenzieren (0 -> quadrieren, 1 -> quadrieren und multiplizieren)
    Erg = f
    for i in 2:Laenge
      Erg = mod(Erg^2, g)
      if Bin[i]==1
        Erg = mod(Erg*f, g)
      end
    end

    return Erg

  end

end