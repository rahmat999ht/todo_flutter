import 'package:flutter/material.dart';
import 'package:todo_flutter/src/pages/login.dart';

import 'widgets/root_nav_bar_page.dart';

class App extends StatelessWidget {
  final bool isAuth;
  const App({super.key, required this.isAuth});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: isAuth ? const RootNavBarPage() : const LoginPage(),
    );
  }
}
