import 'package:get_it/get_it.dart';
import 'package:rick_and_morty/data/character_repository.dart';
import 'package:rick_and_morty/domain/model.dart';
import 'package:rxdart/rxdart.dart';

class CharacterBloc {
  final _repository = GetIt.I.get<CharacterRepository>();
  final _charactersFetcher = PublishSubject<List<Character>>();

  Stream<List<Character>> get allCharacters => _charactersFetcher.stream;

  fetchAllCharacters() async {
    List<Character> characters = await _repository.getCharacters();
    _charactersFetcher.sink.add(characters);
  }

  dispose() {
    _charactersFetcher.close();
  }
}

final bloc = CharacterBloc();