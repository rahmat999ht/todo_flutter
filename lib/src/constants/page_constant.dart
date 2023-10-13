import '../pages/done.dart';
import '../pages/update.dart';
import '../widgets/root_nav_bar_page.dart';

class PageConstant {
  static const widgetOptions = [
    NavBarPage(title: "Todo", page: UpdatePage()),
    NavBarPage(title: "Done", page: DonePage()),
  ];
}
