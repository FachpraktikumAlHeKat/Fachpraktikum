#d-th power residue symbol, Jacobi version
#(a/b)_d, d|q-1, F_q
#e = q-1/d

function power_residue(a,b,e)

  if b==0 || a==0
    return error("a,b!=0")
  end

  if gcd(a,b)!=1
    return 0
  end

  a = mod(a,b)                                          #oberen Teil reduzieren

  if degree(a)==0                                       #oben konstant -> Formel
    return a^( e * Int(degree(b)) )
  end

  #oben und unten tauschen -> rekursiver Aufruf (allgemeines Reziprozitaetsgesetz)
  symbol = leading_coefficient(a)^( e*Int(degree(b)) ) * leading_coefficient(b)^( e*Int(-degree(a)) ) * power_residue(b,a,e)
  if mod( e*degree(a)*degree(b), 2 )==1
  #if last(base( fmpz(e*degree(a)*degree(b)), 2 ))=='1'
      symbol = (-1) * symbol
  end

  return symbol

end
