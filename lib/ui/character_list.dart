import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../blocs/characters_bloc.dart';
import '../domain/model.dart';
import 'character_view.dart';

RefreshController _refreshController = RefreshController(initialRefresh: false);

void _onRefresh() async {
  await bloc.fetchAllCharacters();
  _refreshController.refreshCompleted();
}

characterSelected(BuildContext context, Character character) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => buildCharacterView(character)),
  );
}

Widget buildCharacterCard(BuildContext context, Character character) {
  return Card(
    semanticContainer: true,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 10,
    child: Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          character.imageUrl,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          },
          fit: BoxFit.cover,
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => characterSelected(context, character),
            child: Container(
              padding: const EdgeInsets.only(bottom: 10),
              alignment: Alignment.bottomCenter,
              child: Text(
                character.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    backgroundColor: Colors.grey.withOpacity(0.5)),
              ),
            ),
          ),
        ),
      ],
    ),
    color: Colors.teal[200],
  );
}

Widget buildCharacterListView(BuildContext context, List<Character>
characters) {
  return SmartRefresher(
    child: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children:
        characters.map((e) => buildCharacterCard(context, e)).toList()),
    controller: _refreshController,
    onRefresh: _onRefresh,
  );
}