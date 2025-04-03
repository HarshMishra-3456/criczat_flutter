import 'package:hive_flutter/hive_flutter.dart';

class InitializeStorage {
  dynamic initbox;

  InitializeStorage();

  init() async {
    await Hive.initFlutter();
    initbox = await Hive.openBox('storagebox');
    return initbox;
  }
}

class Storage {
  InitializeStorage dbStorage = InitializeStorage();

  Storage();

  getItem(String key) async {
    var box = await Hive.openBox('storagebox');
    var value = await box.get(key);
    return value;
  }

  setItem(String key, dynamic value) async {
    var box = await Hive.openBox('storagebox');
    await box.put(key, value);
    return;
  }

  deleteItem(String key) async {
    var box = await Hive.openBox('storagebox');
    await box.delete(key);
    return;
  }
}