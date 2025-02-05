def longueurs_blocs(rangee):
    res = []
    cpt = 0
    for pixel in rangee:
        if pixel == 1:
            cpt += 1
        else:
            if cpt > 0:
                res.append(cpt)
                cpt = 0
    if cpt > 0:
        res.append(cpt)
    return res


def verifie(contraintes, rangee):
    return longueurs_blocs(rangee) == contraintes


def coloriable(rangee, k):
    n = len(rangee)
    if n < k:
        return False
    if n > k and rangee[k] == 1:
        return False
    return True


def completable(contraintes, rangee):
    if verifie(contraintes, rangee):
        return True
    if len(rangee) == 0:
        return False

    # cas 1
    k = contraintes[0]
    if coloriable(rangee, k) and completable(contraintes[1:], rangee[k+1:]):
        return True

    # cas 2
    if rangee[0] == 0 and completable(contraintes, rangee[1:]):
        return True

    # échec
    return False


def solutions(contraintes, rangee):
    def aux(contraintes, rangee, i, acc):
        if verifie(contraintes, rangee):
            return [acc.copy()]
        if len(rangee) == 0:
            return []

        res = []
        # essai 1 : en coloriant tout de suite
        k = contraintes[0]
        if coloriable(rangee, k):
            acc[i:i+k] = [1] * k
            res.extend(aux(contraintes[1:], rangee[k+1:], i+k+1, acc))
        # essai 2 : en coloriant plus tard
        if rangee[0] == 0:
            acc[i] = 0
            res.extend(aux(contraintes, rangee[1:], i+1, acc))
        # échec des deux essais
        return res

    return aux(contraintes, rangee, 0, [0] * len(rangee))
