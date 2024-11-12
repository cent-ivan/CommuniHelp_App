class AnnouncementModel {
  bool? isUrgent;
  String? level;
  String? date;
  String? municipality;
  String? title;
  String? content;
  DateTime? expiresAt;

  //Business logic will set when the announcement expires
  AnnouncementModel(
    {
    this.expiresAt,
    required this.isUrgent,
    required this.level,
    required this.date,
    required this.municipality,
    required this.title, 
    required this.content
  });

  //to easily make json formats.
  toJson() {
    return {
      "Urgent" : isUrgent,
      "Level" : level,
      "Date" : date,
      "Content": content,
      "Title": title,
      "Municipality" : municipality,
      "Expires" : expiresAt
    };
  }
}