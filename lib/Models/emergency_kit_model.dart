
import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 0)
class EmergencyKitModel {
  @HiveField(0)
  String? title;

  @HiveField(1)
  bool? isChecked;

  @HiveField(2)
  dynamic imagePath;

  EmergencyKitModel({
    required this.title,
    required this.isChecked,
    required this.imagePath
  });
}