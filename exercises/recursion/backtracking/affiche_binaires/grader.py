def chaines_binaires_aux(n, prefixe):
    if n <= len(prefixe):
        return prefixe + '\n'
    else:
        return (chaines_binaires_aux(n, prefixe + '0')
                + chaines_binaires_aux(n, prefixe + '1'))


def chaines_binaires(n):
    if n == 0:
        return ''
    else:
        return chaines_binaires_aux(n, '')


test('Exécution sans erreur ni affichage', output='')

begin_test_group("Test de la fonction <code>affiche_binaires_prefixe</code>")

test_function_code("affiche_binaires_prefixe",
                   no_return=True, no_loop=True,
                   should_call=['affiche_binaires_prefixe'])

test_function_call('affiche_binaires_prefixe', 3, '000',
                   output=chaines_binaires_aux(3, '000'),
                   result=None)

test_function_call('affiche_binaires_prefixe', 3, '0',
                   output=chaines_binaires_aux(3, '0'),
                   result=None,
                   detect_recursion=True)

begin_test_group("Test de la fonction <code>affiche_binaires</code>")

test_function_code("affiche_binaires",
                   no_return=True, no_loop=True,
                   should_call=['affiche_binaires_prefixe'])

test_function_call('affiche_binaires', 0,
                   output=chaines_binaires(0),
                   result=None)

test_function_call('affiche_binaires', 3,
                   output=chaines_binaires(3),
                   result=None,
                   detect_recursion=True)
