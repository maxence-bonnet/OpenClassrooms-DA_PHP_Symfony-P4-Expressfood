# Projet 4 du parcours développeur d'application PHP / Symfony chez OpenClassrooms

Important :
>Ces documents ne consituent en aucun cas une version de référence pour valider le projet Expressfood.
>Je les partage simplement à titre d'exemple.

Vous trouverez ici ma version  des diagrammes et autres documents demandés pour la réalisation du projet. Il est important de comprendre que l'approche UML pour ce projet se limite à une base de communication, c'est pourquoi les schémas ne seront pas aussi détaillés et / ou complexes que d'autres diagrammes de conception que l'on peut retrouver sur de nombreux tutoriels. L'objectif principal ici est de présenter des schémas clairs (épurés) et compréhensibles, tout en respectant le besoin client.

Un problème notable de ce projet : les exigences des mentors et évaluateurs peuvent être très différentes sur des fonctionnalités à intégrer, des détails sur les diagrammes à afficher ou non.

Même si ça n'est précisé nul part dans mission, il est judicieux de préparer quelques requêtes SQL qui pourront prouver que vous savez vous balader confortablement dans une base de données.

Même si la partie conception / UML peut-être perçue comme ennuyeuse, pensez bien qu'elle vous sera indispensable pour tous les projets qui vont suivre, il est donc important de bien assimiler les concepts et de ne pas passer trop vite dessus. :innocent:


Les diagrammes de cas d'utilisations, séquences, classe ont été réalisés avec : https://cacoo.com/
Le modèle physique de données a été construit sur la page Concepteur de phpMyAdmin, après avoir préalablement créé toutes les tables.

# Concevez la solution technique d'une application de restauration en ligne, ExpressFood

## Mission :

Vous venez d'être recruté par la toute jeune startup ExpressFood. Elle ambitionne de livrer des plats de qualité à domicile en moins de 20 minutes grâce à un réseau de livreurs à vélo.

Chaque jour, ExpressFood prépare 2 plats et 2 desserts à son QG en collaboration avec des chefs expérimentés. Ces plats sont conditionnés à froid puis transmis à des livreurs à domicile qui "maraudent" ensuite dans les rues en attendant une livraison. Dès qu'un client a commandé, l'un des livreurs (qui possède déjà les plats dans un sac) est missionné pour livrer en moins de 20 minutes.

Sur son application, ExpressFood propose à ses clients de commander un ou plusieurs plats et desserts. Les frais de livraison sont gratuits. Les plats changent chaque jour.

Une fois la commande passée, le client a accès à une page lui indiquant si un livreur a pris sa commande et le temps estimé avant livraison.

ExpressFood a besoin que vous conceviez sa base de données. Il s'agit de stocker notamment :

La liste des clients
La liste des différents plats du jour
La liste des livreurs, avec leur statut (libre, en cours de livraison) et leur position
La liste des commandes passées
...

Pour structurer votre réflexion, vous utiliserez UML et construirez une suite de diagrammes afin de modéliser les besoins de l’application et le diagramme de classe pour modéliser les entités de l'application. Une fois que les diagrammes vous satisferont, vous réaliserez le schéma de base de données MySQL correspondant, puis vous remplirez la base avec des premières valeurs fictives.

Vous veillerez à produire des schémas UML cohérents par rapport au cahier des charges et respectant les standards UML. Vous concevrez ensuite un schéma de base de données SQL adéquat.

Schémas demandés :

Diagrammes de cas d’utilisation (création d’une commande, ajout d’un plat du jour, livraison d’une commande)
Modèle de données
Diagramme de classes
Diagrammes de séquences (création d’une commande, ajout d’un plat du jour, livraison d’une commande)
 
Livrables 
Pour ce projet, vous fournirez un dossier .zip contenant :

Schéma UML
Base de données MySQL avec un jeu de données de démo
Pour faciliter votre passage au jury, déposez sur la plateforme, dans un dossier nommé “P4_nom_prenom”, tous les livrables du projet. Chaque livrable doit être nommé avec le numéro du projet et selon l'ordre dans lequel il apparaît, par exemple “P4_01_schémaUML”, “P4_02_basededonnées”, et ainsi de suite.

Soutenance
À l'oral, en condition réelle, vous présenterez votre projet. Votre évaluateur jouera le rôle du client.

La soutenance se déroule comme suit :

La présentation de votre base de données et vos schémas UML : 15-20 minutes
Un moment questions-réponses : 10 minutes
Votre évaluateur débriefera avec vous pendant 5 minutes à la fin de la soutenance.

Compétences évaluées

- Concevoir l’architecture technique d’une application à l’aide de diagrammes UML
- Implémenter le schéma de données dans la base
- Réaliser un schéma de conception de la base de données de l’application
- Réaliser des schémas UML cohérents et en accord avec les besoins énoncés