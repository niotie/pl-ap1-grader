def longueurs_blocs(L):
    ans = []
    cumul = 0
    for i in L:
        if i:
            cumul += 1
        elif cumul != 0:
            ans.append(cumul)
            cumul = 0
    if cumul:
        ans.append(cumul)
    return ans

def verifie(C, L):
    return longueurs_blocs(L) == C

def coloriable(L, k):
    return (len(L)==k) or (len(L)>k and L[k] == 0)

def completable(C, L):
    if verifie(C, L):
        return True
    if L==[]:
        return False
    k = C[0]
    return (coloriable(L, k) and completable(C[1:], L[k+1:])) or completable(C, L[1:])
