function PocklingtonZ(N)

#10000100023?

print(N) #,"\t")

  p = 2				            #Primzahlen
  #P_A = [0 for i=1:N]		#Primfaktoren von A
  #P_A = zeros(N)
  #P_A = Array{fmpz,1}(undef, div(N,2))
  P_A = [0]
  #j = 1				            #Zaehler Primfaktoren von A
  A = 1				            #A*B=N-1 die ganze Zeit
  B = N-1


  while A<=sqrt(N)		#finde Produkt aus Primfaktoren von N-1, das > als sqrt(N) ist -> A

    if mod(B,p)==0		#finde Primfaktoren von N-1
      B = B/p
      A = A*p
      #if P_A[j]!=p		#speicher die verschiedenen Primfaktoren in P_A
        #P_A[j+1] = p
      if P_A[end]!=p
        push!(P_A,p)
        #j+=1
      end
    else
      p = next_prime(p)   #Primzahltest!! -> rekursiver Aufruf von Pockl.
    end
  end

  g = gcd(A, Int(B))		#soll gelten: gcd(A,B)=1
  B = B/g
  A = A*g

  F = factor(g)			#brauchen Primfaktorzerlegung von A -> also auch von g
  for f in F
    if !in(f[1],P_A)
      P_A[j+1] = f[1]
      j+=1
    end
  end

  #P_A = P_A[2:j]
  P_A = P_A[2:end]

#=
print(A)
print(", ")
print(B)
print(",\t")

println(gcd(A,Int(B)))

print(P_A)
print(",\t")
=#



x = 100
Erg = [false for i=1:length(P_A)]	#zum ueberpruefen, ob fuer jeden Primfaktor von A ein passendes a_p gefunden werden kann
j = 1

for p in P_A				#pruefe fuer jeden Primfaktor von A

  for a_p in 2:x			#teste ein paar a_p
    #if mod(a_p^(N-1),N)!=1
    if powmod(a_p,N-1,N)!=1
      if gcd(a_p,N)==1
        println(" is not prime")
        return false
      end
    else
      if gcd(fmpz(a_p)^(fmpz((N-1)/p))-1,N)==1
        Erg[j] = true
        j+=1
        break
      end
    end
  end

end

#print(Erg,"\t")

if !in(false,Erg)
  println(" is prime")
  return true
else
  println(" is not prime?")
  return false
end



end
