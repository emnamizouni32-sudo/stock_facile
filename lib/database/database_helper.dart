import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DatabaseHelper {
  DatabaseHelper._internal();

  static final DatabaseHelper instance = DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.windows) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }

    final chemin = join(
      await getDatabasesPath(),
      'stock_facile.db',
    );

    return openDatabase(
      chemin,
      version: 1,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE categories (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nom TEXT NOT NULL UNIQUE,
            description TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE produits (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nom TEXT NOT NULL,
            prix REAL NOT NULL CHECK (prix >= 0),
            quantite INTEGER NOT NULL DEFAULT 0
              CHECK (quantite >= 0),
            disponible INTEGER NOT NULL DEFAULT 1,
            date_ajout TEXT NOT NULL,
            categorie_id INTEGER NOT NULL,
            FOREIGN KEY (categorie_id)
              REFERENCES categories(id) ON DELETE RESTRICT
          )
        ''');

        await db.insert('categories', {
          'nom': 'Alimentation',
          'description': 'Produits secs et conserves',
        });

        await db.insert('categories', {
          'nom': 'Boissons',
          'description': 'Eaux, jus et sodas',
        });

        await db.insert('categories', {
          'nom': 'Hygiène',
          'description': "Savons et produits d'entretien",
        });

        await db.insert('categories', {
          'nom': 'Papeterie',
          'description': 'Cahiers et fournitures',
        });
      },
      onUpgrade: (db, ancienne, nouvelle) async {
        if (ancienne < 2) {
          await db.execute(
            'ALTER TABLE produits '
            'ADD COLUMN seuil_alerte INTEGER NOT NULL DEFAULT 5',
          );
        }
      },
    );
  }
}