# dashboard-ami

Ce script permet de récupérer les données d'un questionnaire d'évaluation stocké dans un fichier au format Excel construit sur le modèle suivant `AMI-IA-Grille-notation.xlsx`. 

## Structure des données

Tous les fichiers Excel correspondant aux évaluations d'un même projet sont enregistrées dans un même sous dossier.
Tous les fichiers Excel contenant des évaluations ont des noms commençant par 6 chiffres.

## Lancement du script

Pour lancer le script dans une console R : 

    R > knitr::knit(input = "index.Rmd")

Dans une console

    $ Rscript -e 'knitr::knit(input = "index.Rmd")'
