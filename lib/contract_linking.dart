import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class ContractLinking extends ChangeNotifier {
  // 1. Configuration Réseau
  // 127.0.0.1 est parfait pour Chrome ou Windows
  final String _rpcUrl = "http://127.0.0.1:7545";
  
  // Note : _wsUrl ne sert plus ici, mais on peut le laisser ou l'enlever
  final String _wsUrl = "ws://127.0.0.1:7545/";

  // 2. VOTRE CLE PRIVEE
  final String _privateKey = "0x286af2d3d9c620c5966cd482ea875db01cb2c552857747fa45d63ef8de4134f4";

  // 3. Variables techniques
  late Web3Client _client;
  bool isLoading = true;

  late String _abiCode;
  late EthereumAddress _contractAddress;
  late Credentials _credentials;
  late DeployedContract _contract;
  late ContractFunction _yourName;
  late ContractFunction _setName;

  String deployedName = "";

  ContractLinking() {
    initialSetup();
  }

  initialSetup() async {
    // --- CORRECTION ICI ---
    // On initialise simplement le client HTTP. 
    // On a supprimé toute la partie WebSocket qui traînait.
    _client = Web3Client(_rpcUrl, Client());
    // ----------------------

    await getAbi();
    await getCredentials();
    await getDeployedContract();
  }

  Future<void> getAbi() async {
    String abiStringFile = await rootBundle.loadString("src/artifacts/HelloWorld.json");
    var jsonAbi = jsonDecode(abiStringFile);

    _abiCode = jsonEncode(jsonAbi["abi"]);
    _contractAddress = EthereumAddress.fromHex(jsonAbi["networks"]["5777"]["address"]);
  }

  Future<void> getCredentials() async {
    _credentials = EthPrivateKey.fromHex(_privateKey);
  }

  Future<void> getDeployedContract() async {
    _contract = DeployedContract(
        ContractAbi.fromJson(_abiCode, "HelloWorld"), _contractAddress);

    _yourName = _contract.function("yourName");
    _setName = _contract.function("setName");

    await getName();
  }

  Future<void> getName() async {
    var currentName = await _client.call(
        contract: _contract, function: _yourName, params: []);

    deployedName = currentName[0];
    isLoading = false;
    notifyListeners();
  }

  Future<void> setName(String nameToSet) async {
    isLoading = true;
    notifyListeners();

    await _client.sendTransaction(
      _credentials,
      Transaction.callContract(
          contract: _contract,
          function: _setName,
          parameters: [nameToSet]
      ),
      chainId: 1337, 
    );

    await getName();
  }
}