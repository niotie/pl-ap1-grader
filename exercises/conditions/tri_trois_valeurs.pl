extends = ../../templates/generic/generic.pl
author = Antoine Meyer &lt;<a href='mailto:antoine.meyer@u-pem.fr'>antoine.meyer@u-pem.fr</a>&gt;
title = Tri de trois valeurs

text ==
On suppose qu'il existe trois variables `a`, `b` et `c` de valeurs quelconques et
comparables entre elles (vous n'avez donc pas à les initialiser ni à les lire).

Écrire un programme dont l'exécution affiche (à l'aide de la fonction `print`)
les valeurs de `a` `b` et `c` dans l'ordre croissant, séparées par des espaces,
suivies d'un retour à la ligne.

**Par exemple,** si on suppose qu'au début du programme `a` vaut `5`, `b` vaut `1`
et `c` vaut 3, le programme devra afficher *précisément* la chaîne `'1 3 5\n'`.

**Attention :**

- Le programe doit fonctionner quelles que soient les valeurs
  de `a`, `b` et `c` du moment qu'elles sont comparables ;
- Le programme ne doit pas modifier les valeurs des variables `a`, `b` et `c`,
  ni créer de nouvelles variables.==

grader ==
from itertools import permutations

# Ouvre un "groupe de tests" de titre donné
begin_test_group("Tris d'éléments distincts")
# Dans cet exemple on veut faire un test pour chaque permutation de (1, 2, 3)
# On utilise ici un style "verbeux" avec plusieurs appels
for x, y, z in permutations((1, 2, 3)):
    # Donne un titre à la prochaine exécution
    begin_test(f"Exécution avec a = {x}, b = {y}, c = {z}")
    # Fixe les variables globales disponibles pour les prochaines exécution
    set_globals(a=x, b=y, c=z)
    # Lance l'exécution du programme dans les conditions spécifiées
    execute_source()
    # Vérifie la sortie standard obtenue
    assert_output(' '.join(sorted(map(str, (x, y, z)))) + '\n')
    # Vérifie que les variables globales n'ont pas changé
    assert_no_global_change()

# Second groupe de tests avec le plus grand élément doublé
begin_test_group("Tris de chaînes avec un doublon et un plus petit")
for x, y, z in set(permutations(("un", "un", "deux"))):
    begin_test(f"Exécution avec a = {x}, b = {y}, c = {z}")
    set_globals(a=x, b=y, c=z)
    execute_source()
    assert_output(' '.join(sorted(map(str, (x, y, z)))) + '\n')
    assert_no_global_change()

# Troisième groupe de tests avec le plus petit élément doublé
begin_test_group("Tris avec un doublon et un plus grand")
for x, y, z in set(permutations((1, 1, 2))):
    begin_test(f"Exécution avec a = {x}, b = {y}, c = {z}")
    set_globals(a=x, b=y, c=z)
    execute_source()
    assert_output(' '.join(sorted(map(str, (x, y, z)))) + '\n')
    assert_no_global_change()

# Quatrième groupe de tests avec trois éléments identiques
begin_test_group("Tri de trois valeurs identiques")
begin_test(f"Exécution avec a = 1, b = 1, c = 1")
set_globals(a=1, b=1, c=1)
execute_source()
assert_output('1 1 1\n')
assert_no_global_change()
==
