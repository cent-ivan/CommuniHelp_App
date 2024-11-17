import 'package:communihelp_app/View/View_Components/dialogs.dart';
import 'package:communihelp_app/ViewModel/News_View_Model/news_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';


class NewsView extends StatefulWidget {
  const NewsView({super.key});

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> with SingleTickerProviderStateMixin {
  late TabController tabController;


  @override
  void initState()  {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }


  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<NewsViewModel>(context);

    return PopScope(
      canPop: false,
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
        
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Theme.of(context).colorScheme.primary,
            elevation: 1,
            title: ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [Theme.of(context).colorScheme.outline, const Color(0x80FEAE49),   const Color(0xFF57BEE6)],
              ).createShader(bounds),
        
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    viewModel.isLoading = false;
                  });
                },
                child: const Text(
                  "News Feed",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            bottom: TabBar(
              controller: tabController,
              labelColor: Theme.of(context).colorScheme.outline,
              indicatorColor: Color(0xFFFEAE49),
              tabs: [
                Tab(
                  text: "Local",
                ),
                Tab(
                  text: "Weather",
                ), 
                Tab(
                  text: "International",
                ), 
                
              ],
            ),
        
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              iconSize: 20,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          
        
          body: viewModel.isLoading
            ? const Center(child: CircularProgressIndicator())
            : TabBarView(
                controller: tabController,
                children: [
                  NewsListView(articles: viewModel.localArticles),
                  NewsListView(articles: viewModel.weatherArticles),
                  NewsListView(articles: viewModel.interArticles),
                ],
              ),
        ),
      ),
      
    );
  }
}


//News list cards
class NewsListView extends StatefulWidget {
  final List<dynamic> articles;
  const NewsListView({super.key, required this.articles});

  @override
  State<NewsListView> createState() => _NewsListViewState();
}

class _NewsListViewState extends State<NewsListView> {
  GlobalDialogUtil dialog = GlobalDialogUtil();

  @override
  Widget build(BuildContext context) {
    return widget.articles.isEmpty
        ? const Center(child: Text("No news available"))
        : ListView.builder(
            itemCount: widget.articles.length,
            itemBuilder: (context, index) {
              final article = widget.articles[index];
              return GestureDetector(
                onTap: () {
                  //view description
                  seeHeadline(context, article);
                },
                child: Container(
                  height: 90.r,
                  width: 150.r,
                  margin: EdgeInsets.symmetric(vertical: 8.r, horizontal: 8.r),
                  padding: EdgeInsets.all(8).r,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8).r,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                    children: [
                      //image and title
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          article['image_url'] != null
                            ? Container(
                              margin: EdgeInsets.only(right: 10.r),
                              child: Image.network(article['image_url'], 
                                width: 75.r,
                                height: 75.r, 
                                fit: BoxFit.cover
                              )
                            )
                            : Container(margin: EdgeInsets.only(right: 40.r), child: Center(child: const Icon(Icons.image_not_supported , size: 50,))),
                          
                          //news detail content
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //title
                              Text(
                                elipseText(article["title"], 21) ,
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.outline,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.r
                                ),
                              ),
                
                              //date
                              Text(
                                article["pubDate"].substring(0, 10),
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.outline,
                                  fontSize: 12.r
                                ),
                              ),
                
                              Text(
                                article['creator'] != null ? "Published by: ${elipseText(article["creator"][0], 20)}" : "No author",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.outline,
                                  fontSize: 12.r
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                
                    ],
                  ),
                ),
              );
            },
          );
  }

  //for overflowing text
  String elipseText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    }
    return '${text.substring(0, maxLength)}...';
  }


  void seeHeadline(BuildContext context, Map article) {
    showDialog(context: context,
      builder: (context) {
        return SimpleDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.r),)
          ),
          contentPadding: EdgeInsets.all(16).r,
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  article['image_url'] != null
                  ? Center(
                    child: Container(
                        margin: EdgeInsets.only(right: 15.r),
                        child: Image.network(article['image_url'], 
                          width: 235.r,
                          height: 165.r, 
                          fit: BoxFit.cover
                        )
                    ),
                  )
                  : Center(child: const Icon(Icons.image_not_supported , size: 60,)),
              
                  SizedBox(height: 8.r,),
              
                  Text(
                    article['title'] ?? "No Title",
                    style: TextStyle(
                      fontSize: 16.r,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.outline
                    ),
                  ),
              
                  SizedBox(height: 12.r,),
              
                  Text(
                    "Published: ${article['pubDate'].substring(0, 10) ?? "No Date"}",
                    style: TextStyle(
                      fontSize: 14.r,
                      color: Theme.of(context).colorScheme.outline
                    ),
                  ),
              
                  SizedBox(height: 16.r,),
              
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary
                    ),
                    child: Text(
                      article['description'] ?? "No Description",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 14.r,
                        color: Theme.of(context).colorScheme.outline
                      ),
                    ),
                  ),
              
                  SizedBox(height: 12.r,),
                ],
              ),
            ),

            //redirect to website
            MaterialButton(
              onPressed: () {
                try {
                  launchUrl(Uri.parse(article["link"]));
                } catch (e) {
                  dialog.errorDialog(context, "Cannot visit link");
                }
                
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.r),)
              ),
              color: Color(0xFFFEAE49),
              child: Text(
                "Read More",
                style: TextStyle(
                  color: Color(0xFF3D424A)
                ),
              ),
            )
          ],
        );
      }
    );
  }


}

