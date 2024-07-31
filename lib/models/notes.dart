class Note {
  int id = 0;
  String description = "";
  bool isCompleted = false;

  Note({required this.id, required this.description, this.isCompleted = false});

  Map<String, dynamic> toJson() => {
        'id': id,
        'description': description,
        'isCompleted': isCompleted,
      };

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      description: json['description'],
      isCompleted: json['isCompleted'],
      id: json['id'],
    );
  }
}
