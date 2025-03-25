abstract class StorageService {
  /// Stores a JSON object in memory
  Future<void> save(String key, Map<String, dynamic> value);

  /// Retrieves a JSON object from memory
  Future<Map<String, dynamic>?> get(String key);

  /// Deletes an object from memory
  Future<void> delete(String key);
}
