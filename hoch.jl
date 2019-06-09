function hoch(a,b)
  if b==0
    return 1
  else
    return a*hoch(a,b-1)
  end
end
