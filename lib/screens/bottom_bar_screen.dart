// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../core/theme/app_colors.dart';
// import '../providers/bottom_bar_provider.dart';
// import 'event_list_screen.dart';
// import 'profile_screen.dart';
//
// class BottomBarScreen extends StatelessWidget {
//   const BottomBarScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final List<Widget> screens = [
//       const EventListScreen(),
//       const ProfileScreen(),
//     ];
//
//     return Scaffold(
//       body: Consumer<BottomBarProvider>(
//         builder: (context, bottomBarProvider, child) =>
//             screens[bottomBarProvider.currentIndex],
//       ),
//       bottomNavigationBar: Consumer<BottomBarProvider>(
//         builder: (context, bottomBarProvider, child) => BottomNavigationBar(
//           currentIndex: bottomBarProvider.currentIndex,
//           onTap: (index) {
//             bottomBarProvider.setCurrentIndex(index);
//           },
//           type: BottomNavigationBarType.fixed,
//           selectedItemColor: AppColors.primaryColor,
//           unselectedItemColor: AppColors.grey,
//           backgroundColor: Colors.white,
//           items: const [
//             BottomNavigationBarItem(
//               icon: Icon(Icons.event),
//               label: 'Events',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.person),
//               label: 'Profile',
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:klikshikdemo/core/constants/app_constants.dart';
import 'package:provider/provider.dart';
import '../core/theme/app_colors.dart';
import '../providers/bottom_bar_provider.dart';
import 'event_list_screen.dart';
import 'profile_screen.dart';

class BottomBarScreen extends StatelessWidget {
  const BottomBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      const EventListScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: Consumer<BottomBarProvider>(
        builder: (context, bottomBarProvider, child) =>
            screens[bottomBarProvider.currentIndex],
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: AppConstants.bottomBarHeight,
        decoration: BoxDecoration(color: AppColors.grey2B2),
        child: Consumer<BottomBarProvider>(
          builder: (context, bottomBarProvider, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavItem(
                  context: context,
                  // icon: Icons.celebration,
                  icon: AppConstants.eventIconUrl,
                  label: 'EVENTS',
                  index: 0,
                  isSelected: bottomBarProvider.currentIndex == 0,
                  onTap: () => bottomBarProvider.setCurrentIndex(0),
                ),
                _buildNavItem(
                  context: context,
                  // icon: Icons.person_outline,
                  icon: AppConstants.profileIconUrl,
                  label: 'PROFILE',
                  index: 1,
                  isSelected: bottomBarProvider.currentIndex == 1,
                  onTap: () => bottomBarProvider.setCurrentIndex(1),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required String icon,
    required String label,
    required int index,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        children: [
          Container(
            height: AppConstants.bottomBarIconHeight,
            width: AppConstants.bottomBarIconWidth,
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: isSelected
                ? BoxDecoration(
                    color: AppColors.yellow5D4,
                    borderRadius: BorderRadius.circular(16),
                  )
                : null,
            child: Center(
              child: Image.asset(
                icon,
                color: isSelected ? AppColors.yellowD5B : Colors.grey[400],
                height: index == 0 ? 24 : 50,
                width: index == 0 ? 24 : 50,
              ),
              // Icon(
              //   icon,
              //   color: isSelected ? AppColors.yellowD5B : Colors.grey[400],
              //   size: 22,
              // ),
            ),
          ),
          if (isSelected) ...[
            Text(
              label,
              style: TextStyle(
                color: AppColors.yellowFFC,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
