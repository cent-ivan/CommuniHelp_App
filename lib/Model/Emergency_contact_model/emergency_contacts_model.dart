import 'package:hive_flutter/hive_flutter.dart';

part 'emergency_contacts_model.g.dart';

@HiveType(typeId: 1)
class EmergencyContactsModel {
  @HiveField(0)
  String? contactType;

  @HiveField(1)
  String? telecom;

  @HiveField(2)
  String? number;

  @HiveField(3)
  String? contactName;

  @HiveField(4)
  String? url;


  EmergencyContactsModel({
    required this.contactType, 
    required this.telecom,
    required this.number, 
    required this.contactName,
    required this.url
  });
}