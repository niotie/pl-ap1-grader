def longueurs_blocs(rangee):
    compteur = 0
    res = []
    for elem in rangee:
        if elem == 1:
            compteur += 1
        if elem == 0:
            if compteur != 0:
                res.append(compteur)
                compteur = 0
    if compteur != 0:
        res.append(compteur)
    return res

def verifie(contraintes,rangee):
    return contraintes == longueurs_blocs(rangee)

def coloriable(rangee, k):
    if k == 0:
        return True
    if k > len(rangee):
        return False
    if k == len(rangee):
        return True
    return rangee[k] != 1

def completable(contraintes, rangee):
    if verifie(contraintes, rangee):
        return True
    if rangee == []:
        return False
    k = contraintes[0]
    test1 = False
    if coloriable(rangee, contraintes[0]):
        test1 = completable(contraintes[1:], rangee[k+1:])
    if test1:
        return True
    if rangee[0] == 0:
        return completable(contraintes, rangee[1:])
    return False
