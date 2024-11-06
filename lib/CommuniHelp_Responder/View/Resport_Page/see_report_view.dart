import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communihelp_app/CommuniHelp_Responder/ViewModel/responder_report_view_model.dart';
import 'package:communihelp_app/Databases/FirebaseServices/FirestoreServices/get_user_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SeeReportView extends StatefulWidget {
  const SeeReportView({super.key});

  @override
  State<SeeReportView> createState() => _SeeReportViewState();
}

class _SeeReportViewState extends State<SeeReportView> {
  //Firestore instance
  final _db = FirebaseFirestore.instance;

  //viewModel of responder report
  ResponderReportViewModel viewModel = ResponderReportViewModel();

  static final customCache = CacheManager(
    Config(
      "customCacheKey",
      stalePeriod: Duration(days: 30)
    )
  );
  
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<GetUserData>(context);
    return Scaffold(
      appBar: ReportAppBar(),
      body: Padding(
        padding: EdgeInsets.all(8).r,
        child: StreamBuilder(stream: _db.collection('reports').doc(userData.municipality.toUpperCase()).collection("${userData.municipality.toUpperCase()}_reports").snapshots(), 
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            //list all of the reports and listen to stream
            return ListView(
              children: snapshot.data!.docs.map<Widget>((DocumentSnapshot document)  {
                Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                return GestureDetector(
                  onTap: () {
                    viewModel.showReport(context, data);
                  },
                  child: Container(
                    height: 95.r,
                    padding: EdgeInsets.all(8).r,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    margin: EdgeInsets.symmetric(vertical: 8).r,
                    //data
                    child: Row(
                      children: [
                        //Image of the report
                        CachedNetworkImage(
                          cacheManager: customCache,
                          key: UniqueKey(),
                          imageUrl: data["Image"],
                          progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                          imageBuilder: (context, imageProvider) => Image(image: imageProvider, fit: BoxFit.cover, height: 60.r, width: 60.r,)
                        ),

                        SizedBox(width: 15.r,),

                        //displays the report details 
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              elipseText(data["Title"], 25),
                              style: TextStyle(
                                fontSize: 16.r,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.outline,
                              ),
                            ),

                            Text(
                              "DATE: ${data["Date"]}",
                              style: TextStyle(
                                fontSize: 12.r,
                                color: Theme.of(context).colorScheme.outline
                              ),
                            ),

                            Text(
                              "SENDER: ${data["Sender"]}",
                              style: TextStyle(
                                fontSize: 12.r,
                                color: Theme.of(context).colorScheme.outline
                              ),
                            ),

                            Text(
                              "LOCATION: ${data["Location"]}",
                              style: TextStyle(
                                fontSize: 12.r,
                                color: Theme.of(context).colorScheme.outline
                              ),
                            ),
                          ],
                        ),

                        SizedBox(width: 32.r,),

                        //remove button
                        MaterialButton(
                          minWidth: 10.r,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(50.r),)
                          ),
                          onPressed: () {
                            viewModel.deleteReport(document.id, userData.municipality);
                          },
                          child: CircleAvatar(
                            backgroundImage: AssetImage('assets/images/dashboard/remove.png'),
                            radius: 16.r,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }).toList()
            );
          }
        ),
      ),
    );
  }


  //for overflowing text
  String elipseText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    }
    return '${text.substring(0, maxLength)}...';
  }
}

//APP BAR----------------------------------------------------------------------------------------------------
class ReportAppBar extends StatelessWidget implements PreferredSizeWidget{
  const ReportAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).colorScheme.primary,
      elevation: 1,
      title: ShaderMask(
        shaderCallback: (bounds) => LinearGradient(
          colors: [Theme.of(context).colorScheme.outline, const Color(0x80FEAE49),   const Color(0xFF57BEE6)],
        ).createShader(bounds),
          
        child: const Text(
          "Reports",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
          
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new),
        iconSize: 20,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight.r);
}
