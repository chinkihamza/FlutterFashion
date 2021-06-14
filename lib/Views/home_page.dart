import 'package:flutter/material.dart';
import 'package:flutter_fashion/Views/Widgets/bottom_navigator.dart';
import 'package:flutter_fashion/Views/Widgets/page_view_tabs/home_page_tab.dart';
import 'package:flutter_fashion/Views/Widgets/page_view_tabs/saved_page_tab.dart';
import 'package:flutter_fashion/Views/Widgets/page_view_tabs/search_page_tab.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final PageController _tabPageController;
  late int _selectedTab=0;

  @override
  void initState() {
    _tabPageController=PageController();
    super.initState();
  }

  @override
  void dispose() {
    _tabPageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: PageView(
                controller: _tabPageController,
                onPageChanged: (num){
                  setState(() {
                    _selectedTab=num;
                  });
                },
                children: [
                  HomeTab(),
                  SearchTab(),
                  SavedTab(),
                ],
              ),
            ),
            CustomBottomNavigator(tab: _selectedTab,tabPressed: (num){
              _tabPageController.animateToPage(num, duration: Duration(milliseconds: 300), curve: Curves.easeOutCubic);
            },)
          ],
        ),
      ),
    );
  }
}
