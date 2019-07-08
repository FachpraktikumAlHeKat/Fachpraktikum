


q=5
k=ResidueRing(ZZ,q)
kx,x = k["x"]


function bailmatrix(f,q)
    K=parent(f)
    Q=ResidueRing(K,f)
    a=x^2+1
    b=x^3+2*x+4

    A=[Q(0) Q(a); Q(1) Q(b)]
    h=Int128(( ( q^(degree(f)) )^2 )-1)
    B=A^h
    if B==[1 0;0 1]
        return true
    else
        return false
    end


end
