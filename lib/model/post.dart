class Post {
  late String id;
  late String name;
  late int lastSeen;
  late String description;
  late String location;
  late String imageUrl;
  late bool isFound;

  Post(
      {required this.id,
      required this.name,
      required this.lastSeen,
      required this.description,
      required this.location,
      required this.imageUrl,
      required this.isFound});

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageUrl = json['image'];
    description = json['description'];
    location = json['location'];
    lastSeen = json['lastSeen'];
    isFound = json['isFound'];
  }
  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "location": location,
        "lastSeen": lastSeen,
        "isFound": false,
      };
}
