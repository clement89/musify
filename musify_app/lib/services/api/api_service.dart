abstract class ApiService {
  /// Sends a GET request to the specified [endpoint] with optional [queryParams].
  /// Returns the response as a `Map<String, dynamic>`.
  /// Throws an [AppException] if the request fails.
  Future<Map<String, dynamic>> get(String endpoint,
      {Map<String, String>? queryParams});

  /// Sends a POST request to the specified [endpoint] with optional [body] and [headers].
  /// Returns the response as a `Map<String, dynamic>`.
  /// Throws an [AppException] if the request fails.
  Future<Map<String, dynamic>> post(String endpoint,
      {Map<String, dynamic>? body, Map<String, String>? headers});
}
