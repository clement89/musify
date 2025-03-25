import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:musify_app/core/exceptions/app_exception.dart';
import 'storage_service.dart';

class StorageServiceImpl implements StorageService {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  @override
  Future<void> save(String key, Map<String, dynamic> value) async {
    try {
      final jsonString = jsonEncode(value);
      await _secureStorage.write(key: key, value: jsonString);
    } catch (e) {
      throw AppException.storageError;
    }
  }

  @override
  Future<Map<String, dynamic>?> get(String key) async {
    try {
      final jsonString = await _secureStorage.read(key: key);
      if (jsonString == null) return null;
      return jsonDecode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      throw AppException.storageError;
    }
  }

  @override
  Future<void> delete(String key) async {
    try {
      await _secureStorage.delete(key: key);
    } catch (e) {
      throw AppException.storageError;
    }
  }
}
