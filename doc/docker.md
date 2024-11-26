Docker
======

# 0. Introduction

Docker est un outil qui permet de créer, déployer et exécuter des applications dans des conteneurs.  

Les conteneurs sont des environnements isolés qui contiennent tout ce dont une application a besoin pour fonctionner. Ces derniers sont des instances d'une image, créé au préalable.

Nous utiliserons ici une version simplifiée de Docker, Docker Compose, qui permet de définir et de lancer des applications multi-conteneurs.

## installation

Pour installer Docker Compose, il suffit de suivre les instructions de la [documentation officielle](https://docs.docker.com/compose/install/).

```sh
sudo apt install -y curl docker.io
sudo curl -SL https://github.com/docker/compose/releases/download/v2.30.1/docker-compose-linux-armv7 -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
sudo usermod -aG docker <user>
```

# 1. Fichier docker-compose.yml

Ce fichier décrit les différents services du conteneur. Voici un exemple:

```yml
# Version de docker-compose (peut être ignoré pour les versions récentes)
version: '3'

# Liste des services
services:
  <nom>:
    image: <image> # pour trouver des images : https://hub.docker.com/
    # Mapping des ports
    ports:
      - "<port_externe>:<port_interne>"
    # Variables d'environnement de l'image docker (check la doc de l'image)
    environment:
      <var1>: <val1>
      <var2>: <val2>
    # Pour avoir accès à des fichiers persistants de l'image
    volumes:
      - <chemin_hôte>:<chemin_conteneur>
    # Pour lier des conteneurs
    depends_on:
      - <service>
    # Pour exécuter des commandes à la création du conteneur
    command: <commande>
```



# 2. Commandes utiles

Les commandes suivantes doivent être lancées dans le même dossier que le fichier `docker-compose.yml`.

```sh
#lance un conteneur. L'option -d permet de lancer le conteneur en arrière-plan (detached)
docker-compose up -d

#arrête une instance de conteneur
docker-compose down

#affiche les logs d'un conteneur
docker-compose logs

#affiche les conteneurs en cours d'exécution
docker-compose ps

#exécute une commande dans un conteneur
docker-compose exec <service> <commande>
```

Fonctionne partout:

```sh
# affiche toutes les images docker
docker images 

# affiche tous les conteneurs
docker ps

#Supprime le conteneur <id>
# -a pour supprimer tous les conteneurs éteints
# -f pour forcer la suppression
docker image prune <id>
```