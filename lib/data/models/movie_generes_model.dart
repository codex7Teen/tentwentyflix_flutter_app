import 'dart:convert';

class GenreModel {
  // Unique identifier for the genre
  final int id;
  // Name of the genre
  final String name;

  //! Constructor for initializing a GenreModel
  GenreModel({required this.id, required this.name});

  //! Factory method to create a GenreModel from JSON
  factory GenreModel.fromJson(Map<String, dynamic> json) {
    return GenreModel(id: json['id'] ?? 0, name: json['name'] ?? 'Unknown');
  }

  //! Converts a GenreModel instance to JSON
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }

  //! Converts a JSON string to a list of GenreModel instances
  static List<GenreModel> fromJsonList(String str) {
    final jsonData = json.decode(str);
    return (jsonData['genres'] as List)
        .map((e) => GenreModel.fromJson(e))
        .toList();
  }
}
