class Issue {
  String id;
  String title;
  String description;
  String status; // e.g., "Open", "In Progress", "Resolved"
  DateTime dateCreated;

  Issue({String? id, this.title = '', this.description = '', this.status = "Open", DateTime? dateCreated})
      : id = id ?? DateTime.now().microsecondsSinceEpoch.toString(),
        dateCreated = dateCreated ?? DateTime.now();
}
