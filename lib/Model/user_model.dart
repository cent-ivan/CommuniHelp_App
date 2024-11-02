class UserModel {
  String? uid;
  String? profilePicUrl;
  String? name;
  String? birthdate;
  String? gender;
  String? barangay;
  String? municipality;
  String? email;
  String? mobileNumber;
  String? type;
  List? posts;

  UserModel({
    this.uid,
    required this.profilePicUrl,
    required this.name, 
    required this.birthdate, 
    required this.gender, 
    required this.barangay, 
    required this.municipality, 
    required this.email,
    required this.mobileNumber,
    required this.type,
    required this.posts
  });

  //Uploading
  toJson() {
    return {
      "Name" : name,
      "ProfileURL" : profilePicUrl,
      "Birthdate" : birthdate,
      "Gender" : gender,
      "Barangay" : barangay,
      "Municipality" : municipality,
      "Email" : email,
      "MobileNumber" : mobileNumber,
      "Type": type,
      "Posts" : posts
    };
  }

  //Getting
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json["Name"], 
      profilePicUrl: json["ProfileURL"],
      birthdate: json["Birthdate"], 
      gender: json["Gender"], 
      barangay: json["Barangay"], 
      municipality: json["Municipality"], 
      email: json["Email"], 
      mobileNumber: json["MobileNumber"],
      type: json["Type"],
      posts: json["Posts"]
    );
  }
}