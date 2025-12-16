module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",     // Adresse locale
      port: 7545,            // Port de Ganache (Vérifiez sur votre appli Ganache en haut)
      network_id: "*",       // N'importe quel réseau
    },
  },
  // Cette ligne est CRUCIALE pour le TP :
  // Elle dit à Truffle de créer le fichier JSON là où Flutter pourra le trouver.
  contracts_build_directory: "./src/artifacts/",
  
  compilers: {
    solc: {
      version: "0.5.9",      // Doit être la même version que dans vos fichiers .sol
    },
  },
};