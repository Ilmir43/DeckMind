class Game {
  final String id;
  final String name;
  final String image;
  final String shortDescription;
  final String description;

  Game({
    required this.id,
    required this.name,
    required this.image,
    required this.shortDescription,
    required this.description,
  });

  factory Game.fromJson(Map<String, dynamic> json) => Game(
        id: json['id'] as String,
        name: json['name'] as String,
        image: json['image'] as String,
        shortDescription: json['shortDescription'] as String,
        description: json['description'] as String,
      );
}
