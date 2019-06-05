#d-th power residue symbol
#(a/b)_d, b irreducible, d|q-1, F_q

#gcd(a,b) != 1 => (a/b)_d = 0

include("hoch.jl")

function power_residue(a,b,d,symbol,q)
  if b==0
    return error("b!=0")
  end

  if gcd(a,b)!=1
    a_b_d = 0
    return a_b_d
  end

  if degree(a)==0                               #a konstant -> Formel
    return a^( div((q-1),d) * degree(b) )
  end

  a = mod(a,b)                                  #oberen Teil reduzieren
  lc = leading_coefficient(a)                   #und dann in Faktoren aufteilen
  F = factor(a)

  symbol = symbol * hoch( lc, ( div((q-1),d) * degree(b) ) )    #lc konstant -> Formel

  #einzelne Faktoren oben und unten tauschen -> rekursiver Aufruf
  for i in F
    symbol = symbol * hoch( (-1), div(q-1,d) * degree(b) * degree(i[1]) ) * (power_residue( b,i[1],d,1,q )) ^ (i[2])
  end

  return symbol

end
