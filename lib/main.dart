import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rick_and_morty/data/character_repository.dart';
import 'package:rick_and_morty/utils/utils.dart';

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
      home: MyHomePage(title: 'Rick And Morty Characters'),
    );
  }
}

RefreshController _refreshController =
RefreshController(initialRefresh: false);

void _onRefresh() async{
  var characters = await GetIt.I.get<CharacterRepository>().getCharacters();
  setState({}
  )
}

void _onLoading() async{
}


class CharacterList extends StatelessWidget {
  final List<Character> characters;
  const CharacterList({Key? key, this.characters = const []}) : super
      (key: key);

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      child: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          children: characters.map((e) => Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 10,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  e.imageUrl,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null ?
                        loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes! :
                        null,
                      ),
                    );
                  },
                fit: BoxFit.cover,),
                Container(
                  alignment: Alignment.bottomCenter,
                  decoration: const BoxDecoration(
                    color: Colors.black45,
                  ),
                  child: Text(e.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            color: Colors.teal[200],
          )
          ).toList()
      ),
      controller: ,
    );
  }

}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const Center(
        child: CharacterList(),
      ),
    );
  }
}
