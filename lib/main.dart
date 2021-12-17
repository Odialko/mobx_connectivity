import 'package:flutter/material.dart';
import 'package:mobx_conectivity/connectivity_screen.dart';
import 'package:mobx_conectivity/stores/connectivity_store.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final store = ConnectivityStore();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Connectivity',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Provider(
        create: (context) => ConnectivityStore(),
        child: ConnectivityScreen(store: store),
      ),
    );
  }
}
