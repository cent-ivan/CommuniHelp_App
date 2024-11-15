import 'package:communihelp_app/Databases/FirebaseServices/FirestoreServices/get_announcement.dart';
import 'package:communihelp_app/Model/announcement_model.dart';
import 'package:intl/intl.dart';

class PostAnnouncementViewModel {
  final announcementDB = GetAnnouncement();

  
  void addAnnouncement(bool isUrgent, String title, String content, String level, String municipality) {
    //auto delete 48 hours
    final expiresAt = DateTime.now().add(Duration(hours: 48));
    
    //format time
    DateTime utcNow = DateTime.now().toUtc();
                    
    // Converting UTC to Philippine time 
    DateTime philippineTime = utcNow.add(Duration(hours: 8));
                    
    DateFormat formatter = DateFormat('dd-MM-yyyy, hh:mm a', 'en_PH');    
    //This will set on when will the announcement expires      
    String formattedDateTime = formatter.format(philippineTime); 

    announcementDB.addAnnouncement(municipality, 
      AnnouncementModel(
        isUrgent: isUrgent, 
        level: level.toUpperCase(), 
        date: formattedDateTime, 
        municipality: municipality.toUpperCase(), 
        title: title, 
        content: content,
        expiresAt: expiresAt
      )
    );
  }
}