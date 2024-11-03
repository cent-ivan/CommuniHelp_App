import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import '../../../../../ViewModel/Inforgraphics_Controller/natural_dis_view_model.dart';

class InfoPageView extends StatefulWidget {
  const InfoPageView({super.key});

  @override
  State<InfoPageView> createState() => _InfoPageViewState();
}

class _InfoPageViewState extends State<InfoPageView> {

  Logger logger = Logger();

 int _currentPage = 0; //shows the index of the current page
 final PageController _controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    final viewModel =  Provider.of<NaturalDisasterViewModel>(context);
    return Scaffold(
      appBar: NaturalAppBar(),
      body: SingleChildScrollView(
        child: SizedBox(
          height: 900.r,
          child: Stack(
            children: [
              PageView(
                controller: _controller, //controls the page
                onPageChanged: (value) {
                  setState(() {
                    _currentPage = value; //change the index when next
                  });
                },
                children: viewModel.assetEnglishPaths[viewModel.disasterPath]!.map((infoPath) {
                  return InteractiveViewer(
                    //for zoom
                    minScale: 0.5,
                    maxScale: 8,
                    child: Image(
                      image: AssetImage(infoPath),
                      fit: BoxFit.fitWidth,
                    )
                  );
                }).toList(),
              ),

              //Top Page indicator
              Positioned(
                top: 10.r,
                right: 170.r,
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    children: List<Widget>.generate( //generate the rows circles
                      viewModel.assetEnglishPaths[viewModel.disasterPath]!.length,
                      (index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5).r,
                        child: GestureDetector(
                          onTap: () {
                            _controller.animateToPage( //animates the switching of page
                              index, 
                              duration: Duration(milliseconds: 600), 
                              curve: Curves.easeIn
                            );
                          },
                          child: CircleAvatar(
                            radius: 7.r,
                            backgroundColor: _currentPage == index? Color(0xFF57E2E6) : Colors.transparent,
                            child: CircleAvatar(
                              radius: 6.r,
                              backgroundColor: _currentPage == index? Color(0xFF57BEE6) : Color(0x80F8F8F8),
                            ),
                          ),
                        ),
                      )
                    ),
                  ),
                ),
              ),


              //Bottom page indicator
              Positioned(
                bottom: 7.r,
                right: 0.r,
                left: 0.r,
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List<Widget>.generate( //generate the rows circles
                      viewModel.assetEnglishPaths[viewModel.disasterPath]!.length,
                      (index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5).r,
                        child: GestureDetector(
                          onTap: () {
                            _controller.animateToPage( //animates the switching of page
                              index, 
                              duration: Duration(milliseconds: 600), 
                              curve: Curves.easeIn
                            );
                          },
                          child: CircleAvatar(
                            radius: 7.r,
                            backgroundColor: _currentPage == index? Color(0xFF57E2E6) : Colors.transparent,
                            child: CircleAvatar(
                              radius: 6.r,
                              backgroundColor: _currentPage == index? Color(0xFF57BEE6) : Color(0x80F8F8F8),
                            ),
                          ),
                        ),
                      )
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}


//APP BAR--------------------------------------------------------------------------------------
class NaturalAppBar extends StatelessWidget implements PreferredSizeWidget{
  const NaturalAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel =  Provider.of<NaturalDisasterViewModel>(context);
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,//Theme.of(context).colorScheme.primary,
      elevation: 1,
      title: Text(
        viewModel.disasterPath!,
        style: TextStyle(
          color: Theme.of(context).colorScheme.outline,
          fontSize: 20.r,
          fontWeight: FontWeight.bold
        ),
      ),
    
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new),
        iconSize: 20.r,
        onPressed: () {
          
          Navigator.pop(context);
        },
      ),
      
    );
  }
  
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight.r);
}