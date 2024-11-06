import 'package:cached_network_image/cached_network_image.dart';
import 'package:communihelp_app/Databases/FirebaseServices/FirestoreServices/post_report.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResponderReportViewModel {
  static final customCache = CacheManager(
    Config(
      "customCacheKey",
      stalePeriod: Duration(days: 30)
    )
  );

  final firestoreReport = PostReportService();

  //calls from the firestore service of report
  Future deleteReport(String announcementId, String municipality) async {
    await firestoreReport.deleteAnnouncement(announcementId, municipality);
  }

  
  void showReport(BuildContext context, Map<String, dynamic> data) {
    showDialog(context: context, 
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.r),)
          ),
          backgroundColor: Theme.of(context).colorScheme.surface,
          content: SizedBox(
            height: data["Content"].length + (data["Date"].length - 8) + 280.r,
            child: Padding(
              padding: const EdgeInsets.all(2.5).r,
              //content of the report
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      data["Title"],
                      style: TextStyle(
                        fontSize: 20.r,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                
                    SizedBox(height: 4.r,),
                
                    Text(
                      data["Date"],
                      style: TextStyle(
                        fontSize: 16.r,
                
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                
                    SizedBox(height: 12.r,),
                
                    Text(
                      data["Content"],
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 16.r,
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                
                    Divider(color: Theme.of(context).colorScheme.outline,),
                
                    //Image of the report
                    CachedNetworkImage(
                      cacheManager: customCache,
                      key: UniqueKey(),
                      imageUrl: data["Image"],
                      progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      imageBuilder: (context, imageProvider) => InteractiveViewer(
                        //for zoom
                        minScale: 0.5,
                        maxScale: 8,
                        child: Image(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        )
                      )
                    ),
                
                  ],
                
                
                ),
              ),
            ),
          ),
        );
      }
    );
  }


}