

import 'package:flutter/material.dart';
import 'package:time_tracker/screens/Menu/TaskMenu.dart';
import 'package:time_tracker/screens/Menu/projectMenu.dart';
import 'package:time_tracker/screens/TabBar/AllEnt.dart';
import 'package:time_tracker/screens/TabBar/GroupEnt.dart';

import '../dialogs/MenuTile.dart';

class Homemain extends StatefulWidget {
  const Homemain({super.key});

  @override
  State<Homemain> createState() => _HomemainState();
}

class _HomemainState extends State<Homemain> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Time Traking'),
          centerTitle: true,
          backgroundColor: Colors.red[200],
          bottom:const TabBar(
            tabs: [
              Tab(text: 'All Entries'),
              Tab(text: 'Grouped by Projects'),
            ],
            indicatorColor: Colors.black,
            labelColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.tab,
          ),
        ),
        drawer: Drawer(
          width: 300,
          child: Column(
            children: [
              Container(
                height: 200,
                width: 300,
                alignment: Alignment.center,
                color: Colors.red[200],
                child: Text('Menu',style: TextStyle(
                  color: Colors.white,
                  fontSize: 24
                ),),
              ),
              SizedBox(height: 10,),

              MenuTile(title: 'Projects',icon: Icons.folder,ontab: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> ProjectTaskManagementScreen()));
              }),
              MenuTile(title: 'Tasks',icon: Icons.task_rounded,ontab: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Taskmenu()));

              },),
            ],
          ),
        ),

        body: TabBarView(
          children: [
            Allent(),
            Groupent(),
          ],
        ),
      ),
    );
  }
}
