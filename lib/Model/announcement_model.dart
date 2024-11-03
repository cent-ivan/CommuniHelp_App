class AnnouncementModel {
  bool? isUrgent;
  String? level;
  String? date;
  String? municipality;
  String? title;
  String? content;


  AnnouncementModel({
    required this.isUrgent,
    required this.level,
    required this.date,
    required this.municipality,
    required this.title, 
    required this.content
  });

  toJson() {
    return {
      "Urgent" : isUrgent,
      "Level" : level,
      "Date" : date,
      "Content": content,
      "Title": title,
      "Municipality" : municipality
    };
  }
}