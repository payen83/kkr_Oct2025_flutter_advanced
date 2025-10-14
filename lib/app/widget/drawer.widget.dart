import 'package:flutter/material.dart';
import 'package:flutter_advanced_2025/app/constant/color.constant.dart';
import 'package:flutter_advanced_2025/app/view/report.page.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(color: kShrinePink300),
                  child: Text(
                    'Main Menu',
                    style: TextStyle(
                      color: Colors.cyanAccent,
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),                
                MenuItem(
                  itemTitle: 'Reports',
                  itemIcon: Icons.document_scanner,
                  widgetScreen: ReportListPage(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  const MenuItem({
    super.key,
    required this.itemTitle,
    required this.widgetScreen,
    required this.itemIcon,
  });

  final String itemTitle;
  final Widget widgetScreen;
  final IconData itemIcon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(itemIcon),
      title: Text(
        itemTitle,
        style: TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => widgetScreen),
        );
      },
    );
  }
}
