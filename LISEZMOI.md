## **ACFAS 2023**
### Olivier Pilette

### *Visualisation de réseau : une application aux études lithiques en archéologie paléohistorique*

Contact : pilette.o@gmail.com

---
#### Introduction
Ce script a été introduit lors d'une conférence libre, présentée sous forme de [vidéo](https://www.acfas.ca/evenements/congres/90/contribution/visualisation-reseau-application-aux-etudes-lithiques), dans le cadre du 90<sup>e</sup> congrès de l'Association canadienne-française pour l'avancement des sciences ([ACFAS](https://www.acfas.ca/)). Le présent document vise à fournir des informations supplémentaires pour assurer son bon fonctionnement. Les données utilisées pour la démonstration proviennent de mon mémoire de maîtrise. Les données brutes sont disponibles dans un [autre répertoire](https://github.com/opilette/ulaval2023) de mon portail Github.

#### Prérequis
Le script est écrit dans le langage de programmation R. Il nécessite l'installation préalable des paquets `igraph` et `tidyverse`.

#### Fonctionnement
Le script `acfas2023.R` doit être placé dans le même dossier que le fichier à traiter. Ce dernier doit être nommé `donnees.csv` et la virgule est utilisée comme séparateur. Afin que le script fonctionne correctement, il est important que la structure des données respecte précisément le format suivant :

|SITE|CODE|QT|
|:---|:---|:---|
|CcFr-1|mat016|3|
|CcFr-1|mat001|15|
|CiFp-20|mat001|2|
|...|...|...|
|...|...|...|

Le fichier `donnees.csv` qui est joint a été nettoyé. Les données de matériaux lithiques génériques ou indéterminés sont retirés, sans quoi le graphe résultant a une projection distorsionnée.

La variable `SITE` représente le site archéologique. Dans le présent exemple, il s'agit d'un code Borden. La variable `CODE` représente une catégorie d'objets. Dans l'exemple, il s'agit d'un code alphanumérique représentant un matériau lithique. La variable `QT` représente la quantité d'objets. Vous devez vous assurer que votre fichier soit formaté comme le tableau présenté ci-dessus. Il est important qu'il n'y ait qu'une seule catégorie d'objet par ligne.

Pour exécuter le script tapez la ligne de commande suivante : `source('acfas2023.r')`.

#### Résultats
Le script produit un tableau de type liste des arêtes (*edge list*) d'un graphe. Normalement, vous devriez être en mesure d'importer le tableau dans le logiciel [Gephi](https://gephi.org/) sans problème. À la fenêtre du « rapport d'import », il faut choisir l'option « Ne pas fusionner/Don't merge ».
