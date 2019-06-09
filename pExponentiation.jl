#p-adische Exponentiation modulo g


#f^p in F_p

function hochp(f,p)
  erg = 0
  for i in degree(f):-1:0
    erg = erg + (coeff(f,i))^p*x^(i*p)
  end
  return erg
end



function pexpMod(f,e,g,p)		#fuer f^e mod g in F_p

  if nbits(e) <= 63
    return powmod(f, Int(e), g)
  else


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
  Potenzen = [0 for i=1:p]
  Potenzen[1] = 1
  for i in 1:p
    Potenzen[i] = Potenzen[i-1]*f
  end


#Potenzieren (0 -> quadrieren, 1 -> quadrieren und multiplizieren)

    Erg = 1
    for i in 1:Laenge
      #Erg = (Erg^p)*(f^(Bin[i]))
      #Erg = mod(Erg, g)

      #Erg = mod(mod((Erg^p), g)*(f^(Bin[i])), g)
      Erg = mod(mod((hochp(Erg,p)), g)*(Potenzen[Bin[i]+1]), g)
    end

    return Erg

  end
end
