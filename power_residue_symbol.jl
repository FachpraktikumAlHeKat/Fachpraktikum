#d-th power residue symbol
#(a/b)_d, b irreducible, d|q-1, F_q

#Blabla

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

#kx = parent(a)
#q = characteristic(base_ring(kx))

  if degree(a)==0
    return a^( div((q-1),d) * degree(b) )
  end

  a = mod(a,b)
  lc = leading_coefficient(a)
  F = factor(a)

  symbol = symbol * hoch( lc, ( div((q-1),d) * degree(b) ) )
  #push!(symbol, hoch( lc, ( div((q-1),d) * degree(b) ) ))

  for i in F
    symbol = symbol * hoch( (-1), div(q-1,d) * degree(b) * degree(i[1]) ) * (power_residue( b,i[1],d,1,q )) ^ (i[2])
    #push!(symbol, hoch((-1), div(q-1,d) * degree(b) * degree(i[1])) * (power_residue( b,i[1],d,1,q )) ^ (i[2]))
  end

  return symbol


#=
##############################################################################

  push!(symbol_factors, lc^( div((q-1),d) * degree(b) )

##############################################################################
=#
end
