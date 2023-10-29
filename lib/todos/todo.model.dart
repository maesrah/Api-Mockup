class Task {
  final String name;
  bool isDone;

  Task({
    required this.name,
    this.isDone = false,
  });

  Task.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        isDone = json['isDone'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'isDone': isDone,
      };

  // Task.fromMap(Map map)
  //     : this.name = map['name'],
  //       this.isDone = map['isDone'];

  // Map toMap() {
  //   return {
  //     'name': this.name,
  //     'isDone': this.isDone,
  //   };
  // }
}
