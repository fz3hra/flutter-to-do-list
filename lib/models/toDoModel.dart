class Todo {
  String? name;
  bool? isChecked;
  bool? isDelete;

//  constructor
  Todo({required this.name, required this.isChecked, required this.isDelete});

  factory Todo.fromJson(Map<String, dynamic> json)
  {
    final name = (json['name'] ?? "") as String;
    final isChecked = (json['isChecked'] ?? false) as bool;
    final isDelete = (json['isDelete'] ?? false) as bool;
    return Todo(name: name, isChecked: isChecked, isDelete: isDelete);
  }
}