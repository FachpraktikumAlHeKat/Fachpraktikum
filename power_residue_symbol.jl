#d-th power residue symbol, Jacobi version
#(a/b)_d, d|q-1, F_q
#e = q-1/d

function power_residue(a,b,e,q)

  if b==0 || a==0
    return error("a,b!=0")
  end

  if gcd(a,b)!=1
    return 0
  end

  a = mod(a,b)                                          #oberen Teil reduzieren

  if degree(a)==0                                       #oben konstant -> Formel
    return a^(mod( e * Int(degree(b)),q) )
  end

# wir sind in unserem Ring, können also modulo rechnen; mach alles vielleicht schneller.
  #oben und unten tauschen -> rekursiver Aufruf (allgemeines Reziprozitaetsgesetz)
  symbol = leading_coefficient(a)^(mod( e*Int(degree(b)),q )) * leading_coefficient(b)^(mod( e*Int(-degree(a)),q )) * power_residue(b,a,e,q)
  if mod( e*degree(a)*degree(b), 2 )==1
  #if last(base( fmpz(e*degree(a)*degree(b)), 2 ))=='1'
      symbol = (-1) * symbol
  end

  return symbol

end
