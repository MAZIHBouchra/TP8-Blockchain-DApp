# TP 8 : Blockchain et Application Décentralisée (DApp)

Ce dépôt contient le code source du TP "Blockchain et Application décentralisée DAPP". Il s'agit d'une application **Flutter** connectée à une blockchain **Ethereum locale (Ganache)** via des **Smart Contracts Solidity**.

**Faculté des sciences d’Agadir**
**Centre d’Excellence IT – Master IL**
**Réalisé par :** MAZIH Bouchra

---

## Prérequis

Pour exécuter ce projet, vous devez avoir installé :

* **Node.js** & **NPM**
* **Truffle** (`npm install -g truffle`)
* **Ganache** (Interface Graphique - Version GUI)
* **Flutter SDK**

---

## Guide d'installation et d'exécution

Suivez ces étapes pour lancer le projet localement.

### 1. Configuration de la Blockchain (Ganache)

1. Ouvrez **Ganache**.
2. Cliquez sur **Quickstart**.
3. Assurez-vous que le serveur RPC tourne sur le port **7545** (ex: `HTTP://127.0.0.1:7545`).

### 2. Déploiement du Smart Contract

Ouvrez un terminal à la racine du projet et exécutez les commandes suivantes pour compiler et migrer le contrat vers votre Ganache local :

```bash
truffle compile
truffle migrate
```

### 3. Configuration de la Clé Privée (IMPORTANT)

Pour que l'application puisse écrire sur votre instance locale de Ganache, vous devez fournir une clé privée valide.

1. Dans Ganache, choisissez un compte et cliquez sur l'icône de clé (Show Key) pour copier la **Private Key**.
2. Ouvrez le fichier du projet : `lib/contract_linking.dart`.
3. Cherchez la variable `_privateKey` (vers la ligne 15).
4. Remplacez la valeur existante par **votre** clé privée.

```dart
// Exemple dans lib/contract_linking.dart
final String _privateKey = "VOTRE_CLE_PRIVEE_ICI";
```

### 4. Lancement de l'Application Flutter

Installez les dépendances et lancez l'application (compatible Chrome ou Windows) :

```bash
flutter pub get
flutter run -d chrome
```

---

## Technologies utilisées

* **Solidity (v0.5.9)** : Écriture du Smart Contract `HelloWorld`.
* **Truffle** : Compilation et migration du contrat.
* **Flutter (Dart)** : Interface utilisateur (Front-end).
* **Web3dart** : Librairie pour connecter Flutter à la Blockchain Ethereum.
* **Provider** : Gestion d'état de l'application.

## Fonctionnalités

* **Connexion automatique** au déploiement local du contrat.
* **Lecture** : Récupère et affiche le nom stocké dans le contrat (par défaut "Unknown").
* **Écriture** : Permet à l'utilisateur de saisir un nom, de payer les frais de Gas (fictifs), et de mettre à jour la variable sur la Blockchain.
