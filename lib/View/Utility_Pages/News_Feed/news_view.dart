import 'package:communihelp_app/ViewModel/News_View_Model/news_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';


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
    viewModel.callInit();
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
          
              tabs: [
                Tab(
                  text: "Local",
                ),
                Tab(
                  text: "International",
                ), 
                Tab(
                  text: "Weather",
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
                  NewsListView(articles: viewModel.interArticles),
                  NewsListView(articles: viewModel.weatherArticles),
                ],
              ),
        ),
      ),
      
    );
  }
}


//News list cards
class NewsListView extends StatelessWidget {
  final List<dynamic> articles;
  const NewsListView({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {
    return articles.isEmpty
        ? const Center(child: Text("No news available"))
        : ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, index) {
              final article = articles[index];
              return ListTile(
                tileColor: Theme.of(context).colorScheme.primary,
                minVerticalPadding: 12.r,
                leading: article['urlToImage'] != null
                    ? Container(margin: EdgeInsets.only(right: 10.r) ,child: Image.network(article['urlToImage'], width: 80.r, fit: BoxFit.cover))
                    : Container(margin: EdgeInsets.only(right: 40.r), child: const Icon(Icons.image_not_supported , size: 50,)),
                title: article['title'] == "" ?  
                  Text("No title.") : 
                  Text(
                    elipseText(article['title'],30),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.outline,
                      fontSize: 13.r
                    ),
                  ),
                subtitle: Text(
                  article['publishedAt'] != null
                      ?  article['publishedAt'].substring(0, 10) // Show YYYY-MM-DD
                      : "No date",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.outline,
                    fontSize: 10.r
                  ),
                ),
                trailing: TextButton(
                  child: Text("Read More", style: TextStyle(color: Theme.of(context).colorScheme.outline, fontSize: 10.r),),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WebViewScreen(url: article['url']),
                      ),
                    );
                  },
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
}

class WebViewScreen extends StatelessWidget {
  final String url;
  const WebViewScreen({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("News Details")),
      body: Center(
        child: Text("WebView of $url"), // Replace this with actual WebView widget.
      ),
    );
  }
}