class Users {
  late String id;
  late String name;
  late int lastSeen;
  late String description;
  late String location;
  late String imageUrl;
  late bool isFound;

  Users(
      {required this.id,
      required this.name,
      required this.lastSeen,
      required this.description,
      required this.location,
      required this.imageUrl,
      required this.isFound});

  //constructor that can take a JSON object and create a Users
  //instance from it, this function will return a
  //list of user data obtained from the specified URL
  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageUrl = json['image'];
    description = json['description'];
    location = json['location'];
    lastSeen = json['lastSeen'];
    isFound = json['isFound'];
  }
}
