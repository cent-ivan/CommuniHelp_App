class ForumModel {
  String? name;
  String? barangay;
  String? title;
  String? content;
  String? type;
  DateTime? date;
  List<Map>? presses;
  int? likes;

  ForumModel({
    required this.name,
    required this.barangay,
    required this.title,
    required this.content,
    required this.type,
    required this.date,
    required this.presses,
    required this.likes
  });

  //Uploading
  toJson() {
    return {
      "Name": name,
      "Barangay": barangay,
      "Title" : title,
      "Content" : content,
      "Type": type,
      "Date" : date,
      "Presses": presses,
      "Likes": likes
    };
  }

  factory ForumModel.fromJson(Map<String, dynamic> json) {
    return ForumModel(
      name: json["name"], 
      barangay: json["barangay"], 
      title: json["title"], 
      content: json["content"], 
      type: json["type"], 
      date: json["date"], 
      presses: json["presses"], 
      likes: json["likes"]
    );
  }
}