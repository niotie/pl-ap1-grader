def liste_listes_binaires_aux(n, acc):
    if n == len(acc):
        return [acc]
    else:
        res = liste_listes_binaires_aux(n, acc + [0])
        res.extend(liste_listes_binaires_aux(n, acc + [1]))
        return res


def liste_listes_binaires(n):
    return liste_listes_binaires_aux(n, [])
