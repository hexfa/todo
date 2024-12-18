import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Storage {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<void> saveData<T>(String key, T value) async {
    if (value is String) {
      await _secureStorage.write(key: key, value: value);
    } else if (value is int || value is double || value is bool) {
      await _secureStorage.write(key: key, value: value.toString());
    } else {
      throw Exception('Unsupported type');
    }
  }

  Future<T?> getData<T>(String key) async {
    String? value = await _secureStorage.read(key: key);
    if (value == null) {
      return null;
    }

    if (T == String) {
      return value as T;
    } else if (T == int) {
      return int.tryParse(value) as T?;
    } else if (T == double) {
      return double.tryParse(value) as T?;
    } else if (T == bool) {
      return (value.toLowerCase() == 'true') as T?;
    } else {
      throw Exception('Unsupported type');
    }
  }

  Future<void> deleteData(String key) async {
    await _secureStorage.delete(key: key);
  }
}
