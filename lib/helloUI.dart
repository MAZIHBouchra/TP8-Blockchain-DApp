import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'contract_linking.dart';

class HelloUI extends StatelessWidget {
  // Contrôleur pour récupérer le texte saisi par l'utilisateur
  final TextEditingController yourNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // On récupère l'objet qui gère la blockchain (ContractLinking)
    var contractLink = Provider.of<ContractLinking>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("TP Blockchain DApp"),
        centerTitle: true,
        backgroundColor: Colors.cyan[400],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: contractLink.isLoading
              ? const CircularProgressIndicator() // Rond de chargement
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Hello ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                          ),
                          Text(
                            contractLink.deployedName, // Le nom qui vient de la Blockchain !
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.teal),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 29),
                        child: TextField(
                          controller: yourNameController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Votre Nom",
                            hintText: "Entrez votre nom...",
                            icon: Icon(Icons.drive_file_rename_outline),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15),
                          ),
                          onPressed: () {
                            if (yourNameController.text.isNotEmpty) {
                              // On appelle la fonction d'écriture sur la blockchain
                              contractLink.setName(yourNameController.text);
                              yourNameController.clear();
                            }
                          },
                          child: const Text(
                            'Enregistrer sur la Blockchain',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}