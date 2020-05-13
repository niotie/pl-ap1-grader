def liste_listes_binaires_aux(n, acc):
    if n == len(acc):
        return [acc]
    else:
        res = liste_listes_binaires_aux(n, acc + [0])
        res.extend(liste_listes_binaires_aux(n, acc + [1]))
        return res


def liste_listes_binaires(n):
    return liste_listes_binaires_aux(n, [])


def sorted_cmp(a, b):
    return sorted(a) == sorted(b)


test('Exécution sans erreur ni affichage', output='')
test_function_code('liste_listes_binaires')
test_function_call(f'liste_listes_binaires', 0,
                   reference=liste_listes_binaires,
                   res_cmp=sorted_cmp)

for i in range(1, 6):
    test_function_call(f'liste_listes_binaires', i,
                       reference=liste_listes_binaires,
                       detect_recursion=True,
                       res_cmp=sorted_cmp)
