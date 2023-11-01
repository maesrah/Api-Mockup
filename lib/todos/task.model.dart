class Task {
  final String id;
  final String name;
  bool isDone;

  Task({
    required this.id,
    required this.name,
    this.isDone = false,
  });

  Task.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        isDone = json['isDone'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'isDone': isDone,
      };
}
