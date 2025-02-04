

import 'package:flutter/material.dart';
import 'package:time_tracker/screens/Menu/TaskMenu.dart';
import 'package:time_tracker/screens/Menu/projectMenu.dart';
import 'package:time_tracker/screens/TabBar/AllEnt.dart';

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
          bottom:TabBar(
            tabs: [
              Tab(text: 'Tab 1'),
              Tab(text: 'Tab 2'),
            ],
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
            Center(child: Text('Content of Tab 2')),
          ],
        ),
      ),
    );
  }
}
