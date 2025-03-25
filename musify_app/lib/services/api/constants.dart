class ApiConstants {
  // Base API URL
  static const String baseUrl = "http://ax.itunes.apple.com/";

  // API Endpoints
  static const String topSongsEndpoint =
      "/WebObjects/MZStoreServices.woa/ws/RSS/topsongs/limit=20/json";
  // Timeout Durations
  static const Duration connectionTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 10);
}
