
import 'dart:developer';

class Character{
  int id;
  String status;
  String name;
  String imageUrl;
  List<String> episodes;

  Character(this.id, this.status, this.name, this.imageUrl, this.episodes);

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(json["id"], json["status"], json["name"],
        json["image"], json["episode"].cast<String>());
  }

  factory Character.fromNumber(int number) {
    return Character(number, "Alive", "Character $number", "https://blog"
        ".comic-con-paris.com/wp-content/uploads/2020/02/rick-morty-anecdotes"
        "-compressor.jpeg", []);
  }


  static List<Character> fromListJson(Map<String, dynamic> json) {
    return (json["results"] as List<dynamic>).map((e) =>
        Character.fromJson(e)).toList();
  }
}
