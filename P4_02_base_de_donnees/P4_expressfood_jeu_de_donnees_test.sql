-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : dim. 01 août 2021 à 16:20
-- Version du serveur :  10.4.18-MariaDB
-- Version de PHP : 8.0.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `expressfood_donnees_test`
--

-- --------------------------------------------------------

--
-- Structure de la table `adresse`
--

CREATE TABLE `adresse` (
  `id_adresse` int(8) NOT NULL,
  `id_utilisateur` int(8) NOT NULL,
  `numero` int(8) DEFAULT NULL,
  `libelle` varchar(127) NOT NULL,
  `indicateur` varchar(4) DEFAULT NULL,
  `ville` varchar(63) NOT NULL,
  `code_postal` char(5) NOT NULL,
  `commentaire` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `adresse`
--

INSERT INTO `adresse` (`id_adresse`, `id_utilisateur`, `numero`, `libelle`, `indicateur`, `ville`, `code_postal`, `commentaire`) VALUES
(1, 1, 12, 'rue Haute', NULL, 'Bourbriac', '22390', NULL),
(2, 1, 31, 'place de l\'église', 'bis', 'Bourbriac', '22390', NULL),
(3, 2, 14, 'boulevard Carnot', NULL, 'Bourbriac', '22390', NULL),
(4, 2, 18, 'boulevard Carnot', NULL, 'Bourbriac', '22390', NULL),
(5, 3, 46, 'rue Maguerite Poirot', NULL, 'Bourbriac', '22390', NULL),
(6, 4, 128, 'rue du port', NULL, 'Bourbriac', '22390', NULL),
(7, 5, 11, 'Impasse Moilbeurre', 'ter', 'Bourbriac', '22390', 'continuer le chemin juste après le portail rouge'),
(8, 6, 15, 'rue Raymond Travers', NULL, 'Bourbriac', '22390', NULL),
(9, 7, 79, 'boulevard Tichault', NULL, 'Bourbriac', '22390', NULL),
(10, 8, 16, 'rue Gauche', NULL, 'Bourbriac', '22390', NULL),
(11, 9, 2, 'chemin Enlerre', NULL, 'Bourbriac', '22390', NULL),
(12, 10, NULL, 'cité des sables', NULL, 'Bourbriac', '22390', 'appartement 23'),
(13, 11, 5, 'quartier Jacques Cartier', NULL, 'Bourbriac', '22390', NULL),
(14, 6, 24, '4124', 'bis', '2424', '24444', '242');

-- --------------------------------------------------------

--
-- Structure de la table `commande`
--

CREATE TABLE `commande` (
  `id_commande` int(8) NOT NULL,
  `id_utilisateur_client` int(8) NOT NULL,
  `id_adresse` int(8) NOT NULL,
  `statut` enum('en attente','en livraison','livree') NOT NULL,
  `date` datetime NOT NULL COMMENT 'date à laquelle la commande est validée par le client'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `commande`
--

INSERT INTO `commande` (`id_commande`, `id_utilisateur_client`, `id_adresse`, `statut`, `date`) VALUES
(1, 1, 1, 'livree', '2021-07-20 12:10:00'),
(2, 1, 2, 'livree', '2021-07-20 12:12:00'),
(3, 2, 3, 'livree', '2021-07-20 12:15:00'),
(4, 3, 5, 'livree', '2021-07-20 13:12:00'),
(5, 4, 6, 'en livraison', '2021-07-21 11:55:00'),
(6, 5, 7, 'en livraison', '2021-07-21 11:56:00'),
(7, 6, 8, 'en livraison', '2021-07-21 12:02:00'),
(8, 7, 9, 'en attente', '2021-07-31 13:26:56');

-- --------------------------------------------------------

--
-- Structure de la table `livraison`
--

CREATE TABLE `livraison` (
  `id_commande` int(8) NOT NULL,
  `id_utilisateur_livreur` int(8) NOT NULL,
  `date_debut_livraison` datetime NOT NULL,
  `date_fin_estimee` datetime NOT NULL,
  `date_fin` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `livraison`
--

INSERT INTO `livraison` (`id_commande`, `id_utilisateur_livreur`, `date_debut_livraison`, `date_fin_estimee`, `date_fin`) VALUES
(1, 7, '2021-07-20 12:11:00', '2021-07-20 12:21:00', '2021-07-20 12:21:00'),
(2, 8, '2021-07-20 12:13:00', '2021-07-20 12:19:00', '2021-07-20 12:20:00'),
(3, 9, '2021-07-20 12:17:00', '2021-07-20 12:31:00', '2021-07-20 12:30:00'),
(4, 7, '2021-07-20 13:13:00', '2021-07-20 13:21:00', '2021-07-20 13:22:00'),
(5, 7, '2021-07-21 11:57:00', '2021-07-21 12:11:00', NULL),
(6, 9, '2021-07-21 11:58:00', '2021-07-21 12:05:00', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `livreur`
--

CREATE TABLE `livreur` (
  `id_utilisateur` int(8) NOT NULL,
  `statut` enum('indisponible','disponible','en livraison') NOT NULL,
  `livraisons_effectuees` int(5) NOT NULL DEFAULT 0 COMMENT 'total de livraisons réalisées',
  `commandes_refusees` int(5) NOT NULL DEFAULT 0 COMMENT 'total des missions refusées par le livreur',
  `localisation` point DEFAULT NULL COMMENT 'Géolocalisation du livreur'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `livreur`
--

INSERT INTO `livreur` (`id_utilisateur`, `statut`, `livraisons_effectuees`, `commandes_refusees`, `localisation`) VALUES
(7, 'en livraison', 2, 0, 0x0000000001010000001d6f97a2018109c09b38b9dfa13c4840),
(8, 'disponible', 1, 0, 0x000000000101000000001fbc76698309c09b38b9dfa13c4840),
(9, 'en livraison', 1, 0, 0x000000000101000000001fbc76698309c09b38b9dfa13c4840);

-- --------------------------------------------------------

--
-- Structure de la table `plat`
--

CREATE TABLE `plat` (
  `id_plat` int(8) NOT NULL,
  `id_utilisateur_cuisinier` int(8) NOT NULL,
  `titre` varchar(63) NOT NULL,
  `type` enum('plat du jour','dessert') NOT NULL,
  `description` text NOT NULL,
  `image` varchar(127) DEFAULT NULL,
  `prix` float NOT NULL,
  `au_menu` tinyint(1) NOT NULL COMMENT 'boolean',
  `stock` int(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `plat`
--

INSERT INTO `plat` (`id_plat`, `id_utilisateur_cuisinier`, `titre`, `type`, `description`, `image`, `prix`, `au_menu`, `stock`) VALUES
(1, 10, 'quiche aux poireaux', 'plat du jour', 'La quiche aux poireaux est fabriquée avec de la pâte feuilletée, des poireaux (ou seulement des blancs de poireaux), du bouillon de viande, du beurre, un œuf, de la crème épaisse, sel, poivre, muscade et un jaune d’œuf pour dorer la pâte.', 'quiche_poireaux.png', 9.5, 0, 0),
(2, 10, 'salade cesar', 'plat du jour', 'La salade César est à base de laitue romaine, œuf dur, croûtons, parmesan et de « sauce César » à base de parmesan râpé, huile d\'olive, pâte d\'anchois, ail, vinaigre de vin, moutarde, jaune d\'œuf et sauce Worcestershire.', 'salade_cesar.png', 10.5, 0, 0),
(3, 10, 'salade de lentilles', 'plat du jour', 'salade essentiellement constituée de lentilles. Bon appétit.', 'salade_lentilles.png', 4.5, 1, 50),
(4, 10, 'falafels maison', 'plat du jour', 'Assortiment de 5 falafels constitués de boulettes de pois chiches ou de fèves broyés et mélangés à diverses épices, frites dans l\'huile.', 'falafels.png', 6.5, 1, 50),
(5, 11, 'mille feuille', 'dessert', 'Un mille-feuille est une pièce de pâtisserie faite de trois couches de pâte feuilletée et deux couches de crème pâtissière. Le dessus est glacé avec du sucre glace ou du fondant. On peut y ajouter de la confiture ou des fruits.', 'mille_feuille.png', 3.5, 0, 0),
(6, 11, 'tirsamisu maison', 'dessert', 'Le tiramisu s\'élabore généralement avec les ingrédients suivants : œufs, sucre, mascarpone, alcool (traditionnellement du marsala sec ou amaretto), un biscuit à imbiber (génoise, boudoirs (doigts de dames) ou biscuit à la cuillère), café froid, cacao en poudre. Ces ingrédients sont préparés séparément et superposés en couches alternées.', 'tiramisu.png', 4.5, 0, 0),
(7, 11, 'crumble aux pommes', 'dessert', 'Crumble aux pommes, beaucoup de beurre.', 'crumble_pommes.png', 4.5, 1, 50),
(8, 11, 'tarte au citron', 'dessert', 'Délicieuse tarte au citron faite maison, préparée le jour même.', 'tarte_citron.png', 4.5, 1, 50),
(9, 10, '42424', 'dessert', '42424', '42424', 42, 0, 0);

-- --------------------------------------------------------

--
-- Structure de la table `plat_commande`
--

CREATE TABLE `plat_commande` (
  `id_commande` int(8) NOT NULL,
  `id_plat` int(8) NOT NULL,
  `quantite` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `plat_commande`
--

INSERT INTO `plat_commande` (`id_commande`, `id_plat`, `quantite`) VALUES
(1, 1, 2),
(1, 5, 1),
(1, 6, 1),
(2, 2, 1),
(3, 1, 2),
(3, 6, 2),
(4, 1, 2),
(4, 2, 2),
(4, 5, 2),
(4, 6, 2),
(5, 4, 4),
(5, 8, 2),
(6, 3, 5),
(6, 7, 1),
(7, 7, 4);

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

CREATE TABLE `utilisateur` (
  `id_utilisateur` int(8) NOT NULL,
  `pseudonyme` varchar(31) NOT NULL,
  `mot_de_passe` varchar(127) NOT NULL,
  `nom` varchar(63) NOT NULL,
  `prenom` varchar(63) NOT NULL,
  `mail` varchar(127) NOT NULL,
  `telephone` varchar(13) NOT NULL,
  `role` enum('client','cuisinier','livreur') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `utilisateur`
--

INSERT INTO `utilisateur` (`id_utilisateur`, `pseudonyme`, `mot_de_passe`, `nom`, `prenom`, `mail`, `telephone`, `role`) VALUES
(1, 'Jean', '0be0d16dc69c5916fd4cf30a567537a04727a742ffd00f59a26b8103adfac91b8371e1aad7a86f2afafa17340830eb37156bab9de3be40efe9d8b8aa14d7b1d', 'Rochefort', 'Jean', 'rochefort.jean@mail.com', '0612345689', 'client'),
(2, 'Jeanne', 'c0231e42a000801f3cb73a5516d40af294e4b04b79d5222227858b0620a15ce6eb21ce10e1f1940835fe349eaaac9ca66ce6ae0889383d4c7579c9f3e2394f3', 'Moreau', 'Jeanne', 'moreau.jeanne@mail.com', '0612345696', 'client'),
(3, 'Louis', '81050112acf1b4ccbbcf2d943bbca6d374ca821e5c896d2324e460ef8b08d95898976ff203268ab7e6bfbf1e794d529523e267ecf62c36494282534ce42078c', 'De Funes', 'Louis', 'defunes.louis@mail.com', '0612345704', 'client'),
(4, 'Steve', '90a9786afc677f55b32af742c75b81db356a876ce15e5f707790f345ac471c73ac29aede004375d778ce9d042cfd6786d64ea5cb9efc96b59e9018c6137ed13', 'McQueen', 'Steve', 'mcqueen.steve@mail.com', '0612345711', 'client'),
(5, 'Christophe', 'a60854d0d4a771bfe9a0b9e0ad774e83ddffe10433e45bd3ade81bf20a2bd4a4fb06a874e43dd64c7a401932c27520cabe607ce0acf90a3e83a3f3fadc9b4fb', 'Salengro', 'Christophe', 'salengro.christophe@mail.com', '0612345718', 'client'),
(6, 'Gerard', '56fc76ef11acab29d99542227a17cedcfc4547edbfa3aa874f8985a6dea4b216f8d39e5812fd950ccbd1ec4218750b68cf3195f1bfeb14aa253897f1cf43b33', 'Depardieu', 'Gerard', 'depardieu.gerard@mail.com', '0612345725', 'client'),
(7, 'Nairo', '59f8a5bef7568fe66edf22041eec6651faed49bcb6d579028c4ba593248950abc0d5c058359d07bd8e83a50ff98b6554176e063c72a5d94152cf63270f46751', 'Quintana', 'Nairo', 'quintana.nairo@expressmail.com', '0612345729', 'livreur'),
(8, 'Lance', 'bf13a114d55bcefad2f8660b79b09a89d3d3364e25e0394bbc999968315638c955f342b66b4878637aa1a9bc029016ef63c6239e03bc37853677b1c3caa5bbb', 'Amstrong', 'Lance', 'amstrong.lance@expressmail.com', '0612345737', 'livreur'),
(9, 'Peter', 'ea72c79594296e45b8c2a296644d988581f58cfac6601d122ed0a8bd7c02e8bf', 'Sagan', 'Peter', 'amstrong.lance@expressmail.com', '0612345746', 'livreur'),
(10, 'Cyril', 'eac13d52fdf48acb2e76da19ffeb0afec70f6343a30327388dc0c66eb9260b6694658cd514f79cb5c69d400fa0e46877dbe4def13a88fe0715355e0ff61ebf6', 'Lignac', 'Cyril', 'lignac.cyril@expressmail.com', '0612345754', 'cuisinier'),
(11, 'Philippe', '6dd9f55ff5484299d09ffe8d29c7b9101e2f116f3bc5d521e14ea3dfbcb8c926a6ce0936732b823a010d5f33a0d51e98eb1ff54e3936e472c669821712a7577', 'Estebech', 'Philippe', 'estebech.philippe@expressmail.com', '0612345759', 'cuisinier');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `adresse`
--
ALTER TABLE `adresse`
  ADD PRIMARY KEY (`id_adresse`),
  ADD KEY `id_utilisateur` (`id_utilisateur`);

--
-- Index pour la table `commande`
--
ALTER TABLE `commande`
  ADD PRIMARY KEY (`id_commande`),
  ADD KEY `id_utilisateur_client` (`id_utilisateur_client`),
  ADD KEY `id_adresse` (`id_adresse`);

--
-- Index pour la table `livraison`
--
ALTER TABLE `livraison`
  ADD PRIMARY KEY (`id_commande`),
  ADD KEY `id_utilisateur_livreur` (`id_utilisateur_livreur`);

--
-- Index pour la table `livreur`
--
ALTER TABLE `livreur`
  ADD PRIMARY KEY (`id_utilisateur`);

--
-- Index pour la table `plat`
--
ALTER TABLE `plat`
  ADD PRIMARY KEY (`id_plat`),
  ADD KEY `id_utilisateur_cuisinier` (`id_utilisateur_cuisinier`);

--
-- Index pour la table `plat_commande`
--
ALTER TABLE `plat_commande`
  ADD PRIMARY KEY (`id_commande`,`id_plat`),
  ADD KEY `id_plat` (`id_plat`);

--
-- Index pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  ADD PRIMARY KEY (`id_utilisateur`),
  ADD UNIQUE KEY `pseudonyme` (`pseudonyme`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `adresse`
--
ALTER TABLE `adresse`
  MODIFY `id_adresse` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT pour la table `commande`
--
ALTER TABLE `commande`
  MODIFY `id_commande` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `plat`
--
ALTER TABLE `plat`
  MODIFY `id_plat` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  MODIFY `id_utilisateur` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `adresse`
--
ALTER TABLE `adresse`
  ADD CONSTRAINT `adresse_ibfk_1` FOREIGN KEY (`id_utilisateur`) REFERENCES `utilisateur` (`id_utilisateur`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `commande`
--
ALTER TABLE `commande`
  ADD CONSTRAINT `commande_ibfk_2` FOREIGN KEY (`id_utilisateur_client`) REFERENCES `utilisateur` (`id_utilisateur`),
  ADD CONSTRAINT `commande_ibfk_3` FOREIGN KEY (`id_adresse`) REFERENCES `adresse` (`id_adresse`);

--
-- Contraintes pour la table `livraison`
--
ALTER TABLE `livraison`
  ADD CONSTRAINT `livraison_ibfk_1` FOREIGN KEY (`id_commande`) REFERENCES `commande` (`id_commande`) ON DELETE CASCADE,
  ADD CONSTRAINT `livraison_ibfk_2` FOREIGN KEY (`id_utilisateur_livreur`) REFERENCES `livreur` (`id_utilisateur`);

--
-- Contraintes pour la table `livreur`
--
ALTER TABLE `livreur`
  ADD CONSTRAINT `livreur_ibfk_1` FOREIGN KEY (`id_utilisateur`) REFERENCES `utilisateur` (`id_utilisateur`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Contraintes pour la table `plat`
--
ALTER TABLE `plat`
  ADD CONSTRAINT `plat_ibfk_1` FOREIGN KEY (`id_utilisateur_cuisinier`) REFERENCES `utilisateur` (`id_utilisateur`);

--
-- Contraintes pour la table `plat_commande`
--
ALTER TABLE `plat_commande`
  ADD CONSTRAINT `plat_commande_ibfk_2` FOREIGN KEY (`id_commande`) REFERENCES `commande` (`id_commande`) ON DELETE CASCADE,
  ADD CONSTRAINT `plat_commande_ibfk_3` FOREIGN KEY (`id_plat`) REFERENCES `plat` (`id_plat`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
