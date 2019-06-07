#d-th power residue symbol, Jacobi version
#(a/b)_d, d|q-1, F_q

include("hoch.jl")

function power_residue(a,b,d,symbol,q)
  if b==0 ||a==0
    return error("a,b!=0")
  end

  if gcd(a,b)!=1
    a_b_d = 0
    return a_b_d
  end

  if degree(a)==0                               #(!if b irreducible!) a konstant -> Formel
    return a^( div((q-1),d) * degree(b) )
  end

  a = mod(a,b)                                  #oberen Teil reduzieren

  #oben und unten tauschen -> rekursiver Aufruf (allgemeines Reziprozitaetsgesetz)
  symbol = hoch( -1, div(q-1, d) * degree(a) * degree(b) ) * hoch( leading_coefficient(a), degree(b) ) * hoch( leading_coefficient(b), (-degree(a)) ) * symbol(b,a,d,1,q)



  return symbol

end
