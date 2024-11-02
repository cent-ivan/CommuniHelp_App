class ForumModel {
  String? name;
  String? barangay;
  String? title;
  String? content;
  String? type;
  String? date;
  List<Map>? presses;
  int? likes;
  String? profileURL;

  ForumModel({
    required this.name,
    required this.barangay,
    required this.title,
    required this.content,
    required this.type,
    required this.date,
    required this.presses,
    required this.likes,
    required this.profileURL
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
      "Likes": likes,
      "Profile" : profileURL
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
      likes: json["likes"],
      profileURL: json["profileURL"]
    );
  }
}