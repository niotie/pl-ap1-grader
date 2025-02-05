extends = ../../templates/generic/generic.pl
author = Antoine Meyer &lt;<a href='mailto:antoine.meyer@u-pem.fr'>antoine.meyer@u-pem.fr</a>&gt;
title = Logimage

text ==
Dans la première version du projet Logimage, il était question d'écrire une
fonction qui, étant donnée une liste de contraintes et le contenu d'une rangée
contenant des pixels colorés et d'autres non colorés, 
détermine s'il est possible de satisfaire toutes les contraintes en colorant
un certain nombre de pixels de la rangée.

On va essayer de résoudre le problème, en le formalisant de la manière
suivante. Le but est d'écrire une fonction 
`completable(contraintes, pixels)` où `contraintes` est une liste 
d'entiers positifs et `pixels`une liste
contenant exclusivement les entiers 0 et 1.

On dit qu'une liste de 0 et de 1 `lst` vérifie la liste de contraintes
`contraintes` si et seulement si la suite des longueurs des blocs de 1 contigus
dans `lst` est précisément égale à `contraintes`. 

Par exemple, la liste `[0, 1, 1, 0, 0, 1, 0]` 
et la liste `[1, 1, 0, 1, 0, 0, 0]`
contiennent toutes les deux un bloc de 2 pixels colorés suivi d'un bloc de 1
pixel coloré. Elles vérifient donc toutes les deux la liste de contraintes 
`[2, 1]` (et seulement celle-là).

Une fois qu'on sait tester si une liste de 0 et de 1 vérifie une contrainte,
on peut construire un algorithme qui détermine si une ligne est complétable.
 
L'algorithme fonctionne comme suit :

<ul>
<li> Si la liste considérée vérifie déjà les contraintes, répondre "vrai" ;
<li> Sinon, soit `k` la taille de la première contrainte, on essaie deux
 stratégies (à la manière des algorithmes vus précédemment) :
    <ul>
    <li> <div>*Essai 1* : On essaie de compléter la ligne en colorant les pixels
    d'indice
     `0` à `k-1` (et pas un de plus !). Cela n'est possible que si :
        <ul>
        <li> il reste au moins `k` pixels sur la ligne ;
        <li> le pixel d'indice `k`, s'il existe, ne vaut pas déjà 1.
        </ul>
      Dans ce cas, si la ligne est complétable *vis-à-vis des contraintes 
      restantes* à partir de la position `k + 1`, on répond "vrai" 
      (relisez cette phrase trois fois).</div>
    <li> *Essai 2* : On n'essaie pas de colorier le pixel d'indice `0`. 
      Cela n'est possible que si le pixel d'indice 0 n'est pas déjà colorié.  
      Dans ce cas, si la ligne est complétable à partir du pixel d'indice `1`, 
      on répond "vrai".
    </ul>
<li> Si les deux essais ci-dessus échouent, alors la ligne n'est pas complétable
  et on répond "faux".
</ul>
  
**Questions :**

1. Écrire une fonction `longueurs_blocs(rangee)` renvoyant la
 liste des longueurs des blocs colorés dans `rangee`. 

2. Écrire une fonction `verifie(contraintes, rangee)` renvoyant `True`si la
   liste de 0 et de 1 `rangee` vérifie la liste de contraintes `contraintes`,
   et `False` sinon. Cette fonction doit utiliser la fonction 
   `longueurs_blocs`. Et oui, elle fait une ligne.
   
3. Écrire une fonction `coloriable(rangee, k)` renvoyant `True` s'il est
   possible de créer un bloc de `k` pixels colorés (et pas un de plus !) 
   au début de la liste `rangee` en remplaçant des 0 par des 1, et `False` 
   sinon. *Indication* : il n'est pas nécessaire de parcourir plusieurs cases de
   `rangee` ni de la modifier pour de vrai.

4. *(plat de résistance)* Écrire la fonction récursive 
   `completable(contraintes, rangee)`. 

5. *(dessert)* Écrire une fonction récursive 
   `solutions(contraintes, rangee)` recevant les mêmes arguments que la
   fonction précédente et renvoyant la liste des solutions possibles, c'est à
   dire la liste des rangées vérifiant les contraintes que l'on peut former
   en remplaçant certains 0 par des 1 dans `rangee`. 
==

grader ==
from random import randint


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

    # essai 1
    k = contraintes[0]
    if coloriable(rangee, k) and completable(contraintes[1:], rangee[k+1:]):
        return True
    # essai 2
    if rangee[0] == 0 and completable(contraintes, rangee[1:]):
        return True
    # échec des deux essais
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


test('Exécution sans erreur', output='')

begin_test_group('Question 1 - Fonction <code>longueurs_blocs</code>')
test_function_code("longueurs_blocs")

instances = [[], [0], [1]] + [[randint(0, 1)
                               for i in range(randint(10, 20))]
                              for _ in range(10)]
for lst in instances:
    test_function_call('longueurs_blocs', lst, reference=longueurs_blocs)

begin_test_group('Question 2 - Fonction <code>verifie</code>')
test_function_code("verifie")

instances_base = [([], []), ([1], []), ([], [0])]
instances_triv = [([1], [1]), ([1], [0, 1]), ([1], [1, 0]),
                  ([2], [1, 1]), ([3], [1, 1, 1])]
instances_gen = [([1], [0]), ([1], [0, 0]),
                 ([2], [0, 1]), ([2], [1, 0]), ([2], [0, 0]),
                 ([3], [0, 0, 0]),
                 ([3], [1, 0, 0]), ([3], [0, 0, 1]), ([3], [0, 1, 0]),
                 ([3], [0, 1, 1]), ([3], [1, 1, 0]), ([3], [1, 0, 1]),
                 ([2], [1, 0, 1]),
                 ([1, 1], [0, 0, 0]),
                 ([1, 1], [1, 0, 0]), ([1, 1], [0, 1, 0]), ([1, 1], [0, 0, 1]),
                 ([1, 1], [1, 1, 0]), ([1, 1], [0, 1, 1]),
                 ([1, 1], [1, 1, 1]),
                 ([1, 2], [0, 0, 0])]

for contraintes, rangee in instances_base + instances_gen:
    test_function_call('verifie', contraintes, rangee, reference=verifie)

begin_test_group('Question 3 - Fonction <code>coloriable</code>')
test_function_code("coloriable")

instances_col = [([], 0), ([], 1)]
instances_col.extend(([0, 0, 1], i) for i in range(5))

for rangee, k in instances_col:
    test_function_call('coloriable', rangee, k, reference=coloriable)

begin_test_group('Question 4 - Fonction <code>completable</code>')
test_function_code("completable")

for contraintes, rangee in instances_base + instances_triv + instances_gen:
    test_function_call('completable', contraintes, rangee,
                       reference=completable)

begin_test_group('Question 5 - Fonction <code>solutions</code>')
test_function_code("solutions")

for contraintes, rangee in instances_base + instances_triv + instances_gen:
    test_function_call('solutions', contraintes, rangee,
                       reference=solutions)
test_function_call('solutions', [1, 2, 1], [0] * 10, reference=solutions)==
