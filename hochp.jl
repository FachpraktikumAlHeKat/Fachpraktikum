#f^p in F_p

function hochp(f,p)
  erg = 0
  for i in degree(f):-1:0
    erg = erg + (coeff(f,i))^p*x^(i*p)
  end
  return erg
end
