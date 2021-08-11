-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : sam. 31 juil. 2021 à 12:13
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
-- Base de données : `expressfood`
--

-- --------------------------------------------------------

--
-- Structure de la table `adresse`
--

CREATE TABLE `adresse` (
  `id_adresse` int(8) NOT NULL,
  `id_utilisateur` int(8) NOT NULL,
  `numero` int(5) DEFAULT NULL,
  `libelle` varchar(127) NOT NULL,
  `indicateur` varchar(4) DEFAULT NULL,
  `ville` varchar(63) NOT NULL,
  `code_postal` char(5) NOT NULL,
  `commentaire` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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

-- --------------------------------------------------------

--
-- Structure de la table `plat_commande`
--

CREATE TABLE `plat_commande` (
  `id_commande` int(8) NOT NULL,
  `id_plat` int(8) NOT NULL,
  `quantite` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
  MODIFY `id_adresse` int(8) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `commande`
--
ALTER TABLE `commande`
  MODIFY `id_commande` int(8) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `plat`
--
ALTER TABLE `plat`
  MODIFY `id_plat` int(8) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  MODIFY `id_utilisateur` int(8) NOT NULL AUTO_INCREMENT;

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
