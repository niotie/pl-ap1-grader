author=UPEM-L1MI

title=Saisie d'une date

text== 

La durée d'une révolution terrestre (un tour de la Terre autour du Soleil) est
très légèrement inférieure à 365,25 jours. (Explication des années
bissextiles.) Une année est bissextile si elle est divisible par 4 mais pas
par 100, ou bien si elle est divisible par 400.

On suppose qu'il existe une variable `annee` contenant un nombre entier
strictement positif. Écrire un programme affectant à la variable
`est_bissextile` la valeur `True` si la valeur de `annee` désigne une année
bissextile, et `False` sinon.

==

preamble==

import random
random.seed(seed)
annee = random.randint(1, 3000)

==

code==

# on suppose qu'il existe une variable annee contenant un int

est_bissextile = ...  # affecter un booléen

==


grader==

def test_years(title, years):
    res = Feedback(title, template="group")
    for year in years:
        res.subtest(
            test_state_change(
                code,
                {"annee": year},
                {"est_bissextile": isleap(year)}))
    res.set_mean_grade()
    return res


fb = Feedback("Tests : années bissextiles", )
fb.subtest(test_years("Quelques années simples", [1, 4, 100, 400]))
fb.subtest(test_years("Multiples de 400", [1600, 2000, 2400]))
fb.subtest(test_years("Multiples de 100 mais pas 400", [1700, 1800, 2100]))
fb.subtest(test_years("Multiples de 4 mais pas de 100", [1992, 1996, 2004]))
fb.subtest(test_years("Non multiples de 4", [1995, 1997, 2011]))
fb.set_mean_grade()
print(fb)

==
