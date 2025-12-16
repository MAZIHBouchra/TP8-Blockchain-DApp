import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'contract_linking.dart';
import 'helloUI.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Le ChangeNotifierProvider permet d'injecter la logique Blockchain
    // dans toute l'application pour qu'on puisse y accéder depuis l'écran.
    return ChangeNotifierProvider(
      create: (_) => ContractLinking(),
      child: MaterialApp(
        title: 'Hello World DApp',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.cyan[400],
          colorScheme: ColorScheme.dark(
            primary: Colors.cyan[400]!,
            secondary: Colors.deepOrange[200]!,
          ),
        ),
        home: HelloUI(),
      ),
    );
  }
}