import 'dart:async';

import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path/path.dart';

class CacheDatabase {
  Database _database;

  Future initializeDatabase() async {
    final DatabaseFactory dbFactory = databaseFactoryIo;
    _database = await dbFactory.openDatabase(await _getDbPath());
  }

  Future<String> _getDbPath() async {
    const _dbName = 'cache_database.db';

    final dbDirectory = await getApplicationDocumentsDirectory();
    if (!dbDirectory.existsSync()) {
      await dbDirectory.create(recursive: true);
    }

    return join(dbDirectory.path, _dbName);
  }

  Future saveMap(String key, Map<String, dynamic> map) async {
    final store = intMapStoreFactory.store(key);
    await store.add(_database, map);
  }

  Future<List<T>> getAll<T>(
      String key, T Function(Map<String, dynamic>) fromMap) async {
    final store = intMapStoreFactory.store(key);
    final records = await store.find(_database);

    return records.map((snapshot) => fromMap(snapshot.value)).toList();
  }
}