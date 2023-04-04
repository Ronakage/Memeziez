import 'package:flutter/material.dart';
import 'package:memeziez/domain/user_model.dart';
import 'package:memeziez/screens/create_page.dart';
import 'package:memeziez/screens/feed_page.dart';
import 'package:memeziez/screens/profile_page.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

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
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: IndexedStack(
            index: currentPageIndex,
            children: <Widget>[...pages],
          ),
        ),
         bottomNavigationBar: SalomonBottomBar(
           currentIndex: currentPageIndex,
           onTap: (i) => setState(() => currentPageIndex = i),
           items: [
             SalomonBottomBarItem(
               icon: const Icon(Icons.home),
               title: const Text("Feed"),
             ),

             SalomonBottomBarItem(
               icon: const Icon(Icons.create),
               title: const Text("Create"),
             ),

             SalomonBottomBarItem(
               icon: const Icon(Icons.person),
               title: const Text("Profile"),
             ),
           ],
         ),
        // BottomNavigationBar(
        //   currentIndex: currentPageIndex,
        //   onTap: (newPageIndex) {
        //     setState(() {
        //       currentPageIndex = newPageIndex;
        //     });
        //   },
        //   enableFeedback: true,
        //   items: const <BottomNavigationBarItem>[
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.home),
        //       label: '',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.create),
        //       label: '',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.person),
        //       label: '',
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
