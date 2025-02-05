
## Code étudiant

# Code correct :
'''
code = """
est_bissextile = (annee % 4 == 0 and annee % 100 != 0) or annee % 400 == 0 
"""
'''

# Code buggé :
code = """
est_bissextile = annee % 4 == 0 and annee % 100 != 0 
"""


## Évaluateur


