import 'package:todo_flutter/src/pages/todo.dart';

import '../pages/done.dart';
import '../widgets/root_nav_bar_page.dart';

class PageConstant {
  static const widgetOptions = [
    NavBarPage(title: "Todo", page: TodoPage()),
    NavBarPage(title: "Done", page: DonePage()),
  ];
}
