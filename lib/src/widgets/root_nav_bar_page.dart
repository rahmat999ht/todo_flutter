import 'package:flutter/material.dart';
import 'package:todo_flutter/src/constants/page_constant.dart';
import 'package:todo_flutter/src/pages/create.dart';

import '../utils/page_navigation_opacity.dart';

class RootNavBarPage extends StatefulWidget {
  const RootNavBarPage({super.key});

  @override
  State<RootNavBarPage> createState() => _RootNavBarPageState();
}

class _RootNavBarPageState extends State<RootNavBarPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  onCreated() {
    PageNavigationOpacity.toPage(context, const CreatePage());
  }

  @override
  Widget build(BuildContext context) {
    final curentPage = PageConstant.widgetOptions.elementAt(_selectedIndex);
    return Scaffold(
      appBar: AppBar(
        title: Text(curentPage.title),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: curentPage.page,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onCreated,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books_rounded),
            label: 'Todo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_rounded),
            label: 'Done',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class NavBarPage {
  final String title;
  final Widget page;

  const NavBarPage({required this.title, required this.page});
}
