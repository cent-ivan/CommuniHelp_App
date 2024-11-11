import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communihelp_app/Databases/FirebaseServices/FireStorageServices/profile_storage.dart';
import 'package:communihelp_app/Databases/FirebaseServices/FirestoreServices/get_user_data.dart';
import 'package:communihelp_app/Databases/FirebaseServices/FirestoreServices/user_registration.dart';
import 'package:communihelp_app/View/View_Components/dialogs.dart';
import 'package:communihelp_app/View/View_Components/login_dialogs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

//import '../../Models/user_model.dart';
List<String> options =["Male", "Female"]; //for radio list

class ProfileViewModel extends ChangeNotifier{
  static final ProfileViewModel _instance = ProfileViewModel._internal();
  factory ProfileViewModel() {
    return _instance;
  }
  ProfileViewModel._internal();

  Logger logger = Logger(); //for debug message
  final _dialog = GlobalDialogUtil(); //dialgs 
  final dialog = LoginDialogs();
  
  //lazy initializer
  ProfileStorage? _profileStorage;
  ProfileStorage get profileStorage => _profileStorage ??= ProfileStorage();

  
  //show current user
  final user = FirebaseAuth.instance.currentUser!;

  //accessing update user, email and password
  final firestoreAdd = FireStoreAddService();
  
  String currentOption = options[0];

  //text field controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  String? municipalityValue;
  String? barangayValue;

  String? municipalId;
  String? barangayId;

  bool isActive  = false;

  File? image; //edited image
  File? profileImage; //Picked image


  //inserts user data to textcontrollers
  void loadData(BuildContext context) {
    final getService = Provider.of<GetUserData>(context,listen: false);
    for (var option in options) {
      if (option == getService.gender){
        currentOption = option;
      }
    }
    
    nameController.text = getService.name;
    birthdateController.text = getService.birthdate;
    emailController.text = getService.email;
    contactController.text = getService.mobileNumber;

    notifyListeners();
  }
 
  //DatePicker Widget
  Future<void> pickDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context, 
      initialDate: DateTime.now(),
      firstDate: DateTime(1900), 
      lastDate:  DateTime.now(),
      initialEntryMode: DatePickerEntryMode.input,
      confirmText: "Confirm",
      cancelText: "Cancel",
    );

    if (picked != null) {
      //converts DateTime to String then splits the string by spaces then gets the date then splits the date by - 
      String month = picked.toString().split(" ")[0].split("-")[1];
      String day = picked.toString().split(" ")[0].split("-")[2];
      String year = picked.toString().split(" ")[0].split("-")[0];

      birthdateController.text = "$month/$day/$year";
      notifyListeners();
    }
  }

  //Image profile picker GALLERY
  pickImage(imageSource, BuildContext context) async {
    try {
      final ImagePicker picker = ImagePicker();
      XFile? file  = await picker.pickImage(source: imageSource);
      image = File(file!.path);
      notifyListeners();
    }
    catch (e) {
      if (context.mounted) {
        _dialog.errorDialog(context, "No Image pick!");
      }
      
    }
    
  }

  //Crop profile Picture
  cropImage(File? image, BuildContext context) async {
    try {
      final ImageCropper cropper = ImageCropper();
      CroppedFile? croppedFile  = await cropper.cropImage(
        sourcePath: image!.path,
        uiSettings: [
          AndroidUiSettings(
            toolbarColor: Color(0xFF57BEE6),
            toolbarTitle: "Crop Image",
            toolbarWidgetColor: Theme.of(context).colorScheme.surface,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false
          )
        ]
      );
      File? croppedImage = File(croppedFile!.path);
      return croppedImage;
  
    }
    catch (e) {
      if (context.mounted) {
        _dialog.errorDialog(context, "No Image pick!");
      }
      
    }
  }

  //changes the profile in edit profile
  void changeEditProfile(File? newImage) {
    profileImage = newImage;
    notifyListeners();
  }

  void newImage(File? newImage) {
    image = newImage;
    notifyListeners();
  }


  void refreshProfile() {
    nameController.clear();
    birthdateController.clear();
    emailController.clear();
    contactController.clear();
    image = null;
    profileImage = null;
    notifyListeners();
  }


  //Firestore methods-------------------------------------------------------------------
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future updateMunicipal(String? newValue) async {
    municipalId = newValue;
    isActive = true;
    //Gets municipal
    DocumentSnapshot docMunicipal = await _db.collection("municipalities").doc(municipalId).get();
    if (docMunicipal.exists) {
      municipalityValue = docMunicipal["name"];
      
    }
    notifyListeners();
  }

  Future updateBarangay(String? newValue) async {
    barangayId = newValue;
    //Gets barangay
    DocumentSnapshot docBarangay = await _db.collection("municipalities").doc(municipalId).collection("Barangays").doc(barangayId).get();
    if (docBarangay .exists) {
      barangayValue = docBarangay ["name"];
      
    }
    notifyListeners();
  }


  //change email
  Future updateEmail(String id, String email, String password, String newEmail, BuildContext context) async {
    
      await firestoreAdd.updateAuthEmail(id, email, password, newEmail, context);
    
  }

  //change password
  Future updatePassword(String id, String email, String password, String newPass, BuildContext context) async {
    await firestoreAdd.updateAuthPass(id, email, password, newPass, context);
  }


  //Firebase Storage methods------------------------------------------------------------
  //converts unt8 to File type
  Future<File> uint8ListToFile(Uint8List data, String filename) async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = "${directory.path}/$filename";
    File file = File(path);
    return await file.writeAsBytes(data);
  }

  Future<File> assetToFile(String assetPath, String fileName) async {
    final byteData = await rootBundle.load(assetPath);

    // Convert ByteData to Uint8List
    final Uint8List bytes = byteData.buffer.asUint8List();

    // Get a temporary directory to save the file
    final tempDir = await getTemporaryDirectory();

    // Create a file in the temp directory with the specified fileName
    final file = File('${tempDir.path}/$fileName');

    // Write the bytes to the file
    await file.writeAsBytes(bytes);

    return file;
  }


  Future updateUserData(String id, String email, String type) async {
    //Firebase Storage
    final storageRef = FirebaseStorage.instance.ref();
    
    if (profileImage == null) {
      final ref = storageRef.child("user/profile/${id}_profile.jpg"); 
      
      try {
        const oneMegabyte = 1024 * 1024;
        final Uint8List? data = await ref.getData(oneMegabyte);
        //Data in Uint8List
        profileImage = await uint8ListToFile(data!, "profile.jpg");


        await profileStorage.uploadProfile(profileImage!, id , nameController.text, birthdateController.text, currentOption, barangayValue!, municipalityValue!, email, contactController.text, type);
      } on FirebaseException {
        File defaultImage = await assetToFile('asset/images/user.png', 'profile.jpg');
        await profileStorage.uploadProfile(defaultImage, id, nameController.text, birthdateController.text, currentOption, barangayValue!, municipalityValue!, email, contactController.text, type);
      }
    }
    else {
      await profileStorage.uploadProfile(profileImage!, id , nameController.text, birthdateController.text, currentOption, barangayValue!, municipalityValue!, email, contactController.text, type);
    } 
  }


}