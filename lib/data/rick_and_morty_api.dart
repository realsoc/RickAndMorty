class RickAndMortyAPI {
  RickAndMortyAPI();

  static const String _apiBaseUrl = "rickandmortyapi.com";
  static const String _apiPath = "/api/";

  Uri characters() => _buildUri(
    endpoint: "character",
    parametersBuilder: () => {},
  );

  Uri _buildUri({
    required String endpoint,
    required Map<String, dynamic> Function() parametersBuilder,
  }) {
    return Uri(
      scheme: "https",
      host: _apiBaseUrl,
      path: "$_apiPath$endpoint",
      queryParameters: parametersBuilder(),
    );
  }
}