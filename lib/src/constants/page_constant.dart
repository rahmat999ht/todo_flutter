import 'package:flutter/material.dart';
import 'package:todo_flutter/src/pages/todo.dart';

import '../widgets/root_nav_bar_page.dart';

class PageConstant {
  static const widgetOptions = [
    NavBarPage(title: "Todo", page: Todo()),
    NavBarPage(title: "Done", page: Text("Done")),
  ];
}
