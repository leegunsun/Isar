// import 'package:flutter/material.dart';
// import 'package:swf/home/f_home/home.dart';
//
// enum TabItem {
//   home(Icons.home, '홈', HomeView());
//   // favorite(Icons.star, '즐겨찾기', FavoriteFragment(isShowBackButton: false));
//
//   final IconData activeIcon;
//   final IconData inActiveIcon;
//   final String tabName;
//   final Widget firstPage;
//
//   const TabItem(this.activeIcon, this.tabName, this.firstPage, {IconData? inActiveIcon})
//       : inActiveIcon = inActiveIcon ?? activeIcon;
//
//   BottomNavigationBarItem toNavigationBarItem(BuildContext context, {required bool isActivated}) {
//     return BottomNavigationBarItem(
//         icon: Icon(
//           key: ValueKey(tabName),
//           isActivated ? activeIcon : inActiveIcon,
//           color:
//           isActivated ? context.appColors.iconButton : context.appColors.iconButtonInactivate,
//         ),
//         label: tabName);
//   }
// }
