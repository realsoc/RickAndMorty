import 'package:flutter/material.dart';

import '../domain/model.dart';

Widget buildCharacterCircleAvatar(Character character) {
  return Padding(
    padding: const EdgeInsets.all(15),
    child: Column(children: [
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(blurRadius: 15, color: Colors.black, spreadRadius: 1)
          ],
        ),
        child: CircleAvatar(
            radius: 80.0, backgroundImage: NetworkImage(character.imageUrl)),
      ),
      Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          character.name,
          style: const TextStyle(fontSize: 20),
        ),
      )
    ]),
  );
}

Widget _buildVerticalLayout(Character character) {
  return Center(
    child: ListView(
      children: [
        buildCharacterCircleAvatar(character),
        Column(
          children: character.episodes.map((e) => Text(e)).toList(),
        )
      ],
    ),
  );
}

Widget _buildHorizontalLayout(Character character) {
  return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        buildCharacterCircleAvatar(character),
        Expanded(child: Center(
          child: ListView(
            scrollDirection: Axis.vertical,
            children: character.episodes.map((e) => Text(e, textAlign: TextAlign.center,))
                .toList(),
          ),
        ),),
      ]);
}

Widget buildCharacterView(Character character) {
  return Scaffold(
    appBar: AppBar(
      title: Text(character.name),
    ),
    body: OrientationBuilder(builder: (context, orientation) {
      return orientation == Orientation.portrait
          ? _buildVerticalLayout(character)
          : _buildHorizontalLayout(character);
    }),
  );
}
