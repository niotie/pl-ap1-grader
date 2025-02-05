extends = ../../templates/generic/generic.pl

text ==
Écrire une fonction *récursive* `somme_liste(lst)` recevant en paramètre une
liste de nombres et renvoyant la somme de ces nombres.
 
La fonction ne doit provoquer aucun effet de bord (affichage, saisie, 
modification de variable locale ou modification persistente de `lst`). 

    >>> somme_liste([1, 2, 3])
    6
==

grader ==
from random import randrange

test('Exécution sans erreur ni affichage', output="")

test('Existence de la fonction <code>somme_liste</code>',
     functions=["somme_liste"])

begin_test_group("Quelques listes particulières")

for lst in [[], [1], [-1]]:
    test_function_call("somme_liste", lst,
              reference=sum)

begin_test_group("Quelques listes fixées")

for lst in [[1, 2, 3], [1, 5, 8], [-1, 1, -1, 1, -1, 1.0]]:
    test_function_call("somme_liste", lst,
              reference=sum, detect_recursion=True)

begin_test_group("Quelques listes aléatoires")

for _ in range(10):
    lst = [randrange(-999, 1000) for _ in range(randrange(10, 20))]
    test_function_call("somme_liste", lst,
              reference=sum, detect_recursion=True)==
