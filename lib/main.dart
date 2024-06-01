import 'package:flutter/material.dart';
import 'package:mind_map/mind_map.dart';
import 'package:mind_map_demo/pages/Mindmap.dart';
import 'package:mind_map_demo/pages/Tree.dart';

import 'Navbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {
  int currentIndex = 0;
  final pages = [const Tree(), Mindmap()];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[200],
        primaryColor: Colors.greenAccent,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Demo'),
          backgroundColor: Colors.greenAccent,
        ),
        body: pages[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            unselectedItemColor: Colors.greenAccent.shade700,
            selectedItemColor: Colors.white,
            backgroundColor: Colors.greenAccent,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Tree',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Mindmap',
              )
            ],
            onTap: (index) => {
              setState(() {
                currentIndex = index;
              })
            }),
      ),
    );
  }
}