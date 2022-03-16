import 'package:get_it/get_it.dart';
import '../data/character_repository.dart';
import '../data/rick_and_morty_api.dart';
import '../domain/model.dart';
import 'package:http/http.dart' as http;


class Utils {

  static List<Character> generateCharacters(int number) {
    return List.generate(
      number,
      (int index) => Character.fromNumber(index),
    );
  }

  static void initLocator() {
    GetIt.I.registerFactory<CharacterRepository>(() => HttpCharacterRepository
      (api: RickAndMortyAPI(), client : http.Client()));
  }
}
