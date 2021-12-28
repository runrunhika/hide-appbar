import 'package:flutter/material.dart';

class AppBarPage extends StatelessWidget {
  const AppBarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: SliverSafeArea(
              top: false,
              sliver: SliverAppBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                //TabBar Hide true ? false
                pinned: true,
                floating: true,
                snap: true,
                forceElevated: innerBoxIsScrolled,
                title: Text('AppBar', style: TextStyle(color: Colors.black),),
                centerTitle: true,
                bottom: TabBar(
                  indicatorColor: Colors.white,
                  indicatorWeight: 5,
                  tabs: [
                    Tab(icon: Icon(Icons.home), text: 'Home'),
                    Tab(icon: Icon(Icons.list_alt), text: 'Feed'),
                    Tab(icon: Icon(Icons.person), text: 'Profile'),
                    Tab(icon: Icon(Icons.settings), text: 'Settings'),
                  ],
                ),
              ),
            ),
          ),
        ],
        // body: ListView.separated(
        //     padding: EdgeInsets.all(12),
        //     itemBuilder: (context, index) => buildCard(index + 1),
        //     separatorBuilder: (context, index) => SizedBox(
        //           height: 12,
        //         ),
        //     itemCount: 25),

        body: TabBarView(
          children: [
            buildPage('Home'),
            buildPage('Feed'),
            buildPage('Profile'),
            buildPage('Settings Page'),
          ],
        ),
      )),
    );
  }

  Widget buildPage(String text) => SafeArea(
        top: false,
        bottom: false,
        child: Builder(builder: (context) {
          return CustomScrollView(
            slivers: [
              //Version A

              // ListView.separated(
              //     itemBuilder: (context, index) => buildCard(index + 1),
              //     separatorBuilder: (context, index) => SizedBox(
              //           height: 12,
              //         ),
              //     itemCount: 25),

              //Version B

              SliverOverlapInjector(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
              SliverPadding(
                padding: EdgeInsets.all(12),
                sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                  final childCount = 25;
                  final hasSeparator = index != childCount - 1;
                  final double bottom = hasSeparator ? 12 : 0;
                  final child = buildCard(index + 1);

                  return Container(
                    margin: EdgeInsets.only(bottom: bottom),
                    child: child,
                  );
                }, childCount: 25)),
              ),
            ],
          );
        }),
      );

  Widget buildCard(int index) => Container(
        height: 50,
        child: Card(
          elevation: 5,
          child: Text(
            'Item : $index',
            style: TextStyle(fontSize: 20),
          ),
        ),
      );
}
