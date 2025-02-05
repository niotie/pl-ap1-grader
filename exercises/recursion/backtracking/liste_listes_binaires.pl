extends = ../../templates/generic/generic.pl
author = Antoine Meyer &lt;<a href='mailto:antoine.meyer@u-pem.fr'>antoine.meyer@u-pem.fr</a>&gt;
title = Liste des listes binaires

text ==
On souhaite écrire une fonction récursive `liste_listes_binaires(n)` renvoyant 
la liste des mots à `n` caractères dans l'alphabet binaire (`'0'` ou `'1'`), 
dans l'ordre lexicographique.
 
Par exemple:

    >>> liste_listes_binaires(2)
    [[0, 0], [0, 1], [1, 0], [1, 1]]

Le travail demandé est d'écrire la fonction **récursive**
`liste_binaires_prefixe(n, prefixe)` décrite ci-dessus. On pourra s'inspirer 
pour cela de l' algorithme utilisé dans les exercices *Affichage des mots
 binaires* et *Liste des mots binaires*.
==

grader ==
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
==
