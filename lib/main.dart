import 'package:flutter/material.dart';
import 'package:stock_facile/database/database_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DatabaseHelper.instance.database;

  runApp(const StockFacileApp());
}

class StockFacileApp extends StatelessWidget {
  const StockFacileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StockFacile',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.teal,
      ),
      home: const Scaffold(
        appBar: AppBar(title: const Text('StockFacile')),
        body: Center(
          child: Text('Base SQLite initialisée'),
        ),
      ),
    );
  }
}