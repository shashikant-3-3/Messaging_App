import 'package:flutter/material.dart';
import 'package:messaging_app/Pages/recent_conversations_Page.dart';

import './profile_page.dart';
import './search_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late double _height;
  late double _width;

  late TabController _tabController;

  _HomePageState() {
    _tabController = TabController(length: 3, vsync: this, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        textTheme: TextTheme(
          headline6: TextStyle(fontSize: 16),
        ),
        title: Text("JustChat"),
        bottom: TabBar(
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.blue,
          labelColor: Colors.blue,
          controller: _tabController,
          tabs: [
            Tab(
              icon: Icon(
                Icons.people_outline,
                size: 25,
              ),
            ),
            Tab(
              icon: Icon(
                Icons.chat_bubble_outline,
                size: 25,
              ),
            ),
            Tab(
              icon: Icon(
                Icons.person_outline,
                size: 25,
              ),
            ),
          ],
        ),
      ),
      body: _tabBarPages(),
    );
  }

  Widget _tabBarPages() {
    return TabBarView(
      controller: _tabController,
      children: <Widget>[
        SearchPage(_height, _width),
        RecentConversationsPage(_height, _width),
        ProfilePage(_height, _width),
      ],
    );
  }
}
