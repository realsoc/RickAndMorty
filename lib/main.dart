import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rick_and_morty/ui/character_list.dart';
import 'package:rick_and_morty/utils/utils.dart';

import 'blocs/characters_bloc.dart';
import 'domain/model.dart';

void main() {
  Utils.initLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rick And Morty',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: buildMyHomePage('Rick And Morty Characters'),
    );
  }
}

Widget buildMyHomePage(String title) {
  bloc.fetchAllCharacters();
  return Scaffold(
    appBar: AppBar(
      title: Text(title),
    ),
    body: Center(
      child: StreamBuilder<List<Character>>(
          initialData: const [],
          stream: bloc.allCharacters,
          builder: (context, AsyncSnapshot<List<Character>> snapshot) {
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return buildCharacterListView(context,
              snapshot
                  .data!);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return const Center(child: CircularProgressIndicator());
          }),
    ),
  );
}
