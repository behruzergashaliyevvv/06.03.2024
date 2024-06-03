class Plan {
  String id;
  String title;
  String description;
  bool completed; // New property

  Plan({
    required this.id,
    required this.title,
    required this.description,
    this.completed = false, // Default value
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'completed': completed, // Serialize completed status
    };
  }

  factory Plan.fromJson(String id, Map<String, dynamic> json) {
    return Plan(
      id: id,
      title: json['title'],
      description: json['description'],
      completed: json['completed'] ?? false, // Deserialize completed status
    );
  }
}
