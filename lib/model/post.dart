class Post {
  String? id;
  String? name;
  int? lastSeen;
  String? description;
  String? location;
  String? imageUrl;
  bool? isFound;

  Post(
      {this.id,
      this.name,
      this.lastSeen,
      this.description,
      this.location,
      this.imageUrl,
      this.isFound});

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageUrl = json['image'];
    description = json['description'];
    location = json['location'];
    lastSeen = json['lastSeen'];
    isFound = json['isFound'];
  }
}
