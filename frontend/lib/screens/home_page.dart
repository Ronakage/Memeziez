import 'package:flutter/material.dart';
import 'package:memeziez/domain/user_model.dart';
import 'package:memeziez/screens/create_page.dart';
import 'package:memeziez/screens/feed_page.dart';
import 'package:memeziez/screens/profile_page.dart';

class HomePage extends StatefulWidget {
  HomePage({ required this.user, Key? key}) : super(key: key);
  UserModel user;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;
  var pageTitles = ['Feed','Create','Profile'];
  var pages;
  @override
  void initState() {
    super.initState();
    pages = [FeedPage(user: widget.user), CreatePage(user:widget.user), ProfilePage(user:widget.user)];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitles[currentPageIndex]),
        automaticallyImplyLeading: false,
      ),
      body: pages[currentPageIndex],
      bottomNavigationBar:  BottomNavigationBar(
        currentIndex: currentPageIndex,
        onTap: (newPageIndex) {
          setState(() {
            currentPageIndex = newPageIndex;
          });
        },
        enableFeedback: true,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.create),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
      ),
    );
  }
}
