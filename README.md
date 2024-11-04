# HAL2
Hal2 est le serveur central du hs dans le hs pour le hs.
L'idée de cette nouvelle version est d'avoir une architecture en plein de petits services facile à modifier, afin de rendre HAL modulable.
Pour ce faire on a créé un script d'installation à lancer pour installer HAL2.
L'architecture de ce repo d'installation d'HAL2 est la suivante :
-README.md # ce fichier
-hal2.sh   # le fichier d'installation principal
-programs/ # Dossier contenant les scripts d'installation de chaque module
--a.sh     # Script d'intallation du module a

Les scripts d'installation doivent suivre les propriétés suivantes :
- Être exécutable
- Les deux premières lignes doivent êtres les suivantes :

```bash
#!/bin/bash
#Descripteur du module
```

Note : Il est préférable d'avoir un script d'installation du module dans le repo du module, de cette manière le script d'installation dans ce repo se contente de clone le module au bon endroit, lancer le script d'installation et cleaner si besoin est.

