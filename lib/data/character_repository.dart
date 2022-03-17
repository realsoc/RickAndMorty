import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:rick_and_morty/data/rick_and_morty_api.dart';
import 'package:rick_and_morty/domain/model.dart';

abstract class CharacterRepository {
  Future<List<Character>> getCharacters();
}

class HttpCharacterRepository implements CharacterRepository {
  HttpCharacterRepository({required this.api, required this.client});
  final RickAndMortyAPI api;
  final http.Client client;

  @override
  Future<List<Character>> getCharacters() {
    return _getData(
      uri: api.characters(),
      builder: (data) => Character.fromListJson(data),
    );
  }

  Future<T> _getData<T>({
    required Uri uri,
    required T Function(dynamic data) builder,
  }) async {
    try {
      final response = await client.get(uri);
      switch (response.statusCode) {
        case 200:
          final data = json.decode(response.body);
          return builder(data);
        default:
          throw Exception('Error ${response.statusCode} while getting data '
              'from server');
      }
    } on SocketException catch (_) {
      throw Exception('Socket exception');
    }
  }
}