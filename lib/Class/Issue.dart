class Issue {
  String id;
  String title;
  String description;
  String status; // e.g., "Open", "In Progress", "Resolved"
  DateTime dateCreated;

  Issue({String? id, this.title = '', this.description = '', this.status = "Open", DateTime? dateCreated})
      : id = id ?? DateTime.now().microsecondsSinceEpoch.toString(),
        dateCreated = dateCreated ?? DateTime.now();

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'status': status,
        'dateCreated': dateCreated.toIso8601String(),
      };

  factory Issue.fromJson(Map<String, dynamic> json) {
    return Issue(
      id: json['id'] as String?,
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      status: json['status'] as String? ?? 'Open',
      dateCreated: DateTime.tryParse(json['dateCreated'] as String? ?? '') ?? DateTime.now(),
    );
  }
}
