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
test_function_call('solutions', [1, 2, 1], [0] * 10, reference=solutions)