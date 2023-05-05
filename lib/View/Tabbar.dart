import 'package:avinashgatekeeper/Config/Utils/color.dart';
import 'package:avinashgatekeeper/Config/Utils/images.dart';
import 'package:avinashgatekeeper/View/BuilderStaffPage/BuilderStaffPage.dart';
import 'package:avinashgatekeeper/View/DirectoryPage/DirectoryPage.dart';
import 'package:avinashgatekeeper/View/HomePage/HomePage.dart';
import 'package:avinashgatekeeper/View/StaffPage/StaffPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TabbarItem {
  final String lightIcon;
  final String boldIcon;
  final String label;

  TabbarItem({required this.lightIcon, required this.boldIcon, required this.label});

  BottomNavigationBarItem item(bool isbold) {
    return BottomNavigationBarItem(
      icon: Image.asset(isbold ? boldIcon : lightIcon),
      label: label,
    );
  }

  BottomNavigationBarItem get light => item(false);
  BottomNavigationBarItem get bold => item(true);
}

class TabbarScreen extends StatefulWidget {
  const TabbarScreen({super.key});

  @override
  State<TabbarScreen> createState() => _TabbarState();
}

class _TabbarState extends State<TabbarScreen> {
  int _select = 0;

  final screens = [
    HomePage(),
    // StaffPage(),
    BuilderStaffPage(),
    DirectoryPage(),
  ];

  static Image generateIcon(String path) {
    return Image.asset(
      '$path',
      width: 24,
      height: 24,
      color: AppColors.BLACK,
    );
  }

  final List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
      icon: generateIcon(HOME_ICON),
      activeIcon: generateIcon(HOME_ICON),
      label: 'Visitors',
    ),
    // BottomNavigationBarItem(
    //   icon: generateIcon(STAFF_ICON),
    //   activeIcon: generateIcon(STAFF_ICON),
    //   label: 'Staff',
    // ),
    BottomNavigationBarItem(
      icon: generateIcon(STAFF_ICON),
      activeIcon: generateIcon(STAFF_ICON),
      label: 'Builder Staff',
    ),
    BottomNavigationBarItem(
      icon: generateIcon(DIRECTORY_ICON),
      activeIcon: generateIcon(DIRECTORY_ICON),
      label: 'Directory',
    ),
  ];

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_select],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.WHITE,
        elevation: 5,
        type: BottomNavigationBarType.fixed,
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(

            icon: SvgPicture.asset(HOME_ICON_SVG,height: 25,width: 25,color: _select==0?APP_THEME_COLOR:Colors.black87,),
            label: 'Visitors',

          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.contacts_rounded),
          //   label: 'Staff',
          // ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(BUILDER_STAFF_ICON_SVG,height: 25,width: 25,color: _select==1?APP_THEME_COLOR:Colors.black87,),
            label: 'Builder Staff',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(DIRECTORY_ICON_SVG,height: 25,width: 25,color: _select==2?APP_THEME_COLOR:Colors.black87,),
            label: 'Directory',
          ),
        ],
        currentIndex: _select,
        selectedItemColor: APP_THEME_COLOR,
        unselectedItemColor: Colors.black87,
        onTap: ((value) => setState(() => _select = value)),
      ),
    );


  }
}