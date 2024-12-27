import 'package:event_planning/providers/app_language_provider.dart';
import 'package:event_planning/providers/app_theme_provider.dart';
import 'package:event_planning/ui/home_screen/tabs/favorite/favorite_tab.dart';
import 'package:event_planning/ui/home_screen/tabs/home/home_tab.dart';
import 'package:event_planning/ui/home_screen/tabs/map/map_tab.dart';
import 'package:event_planning/ui/home_screen/tabs/profile/profile_tab.dart';
import 'package:event_planning/utils/app_colors.dart';
import 'package:event_planning/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatefulWidget {
  static const routeName = 'Home Screen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<Widget> tabs = [
    HomeTap(),
    MapTap(),
    FavoriteTap(),
    ProfileTap()
  ];
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: AppColors.transparentColor
        ),
        child: BottomAppBar(
          padding: EdgeInsets.all(0),
          color: Theme.of(context).primaryColor,
          shape: CircularNotchedRectangle(),
          notchMargin: 5,
          child: BottomNavigationBar(
            selectedItemColor: AppColors.whiteColor,

            currentIndex: selectedIndex,
              onTap: (index) {
                selectedIndex = index;
                setState(() {

                });
              },
              items: [
                buildBottomNavItem(index: 0,iconSelectedName:AssetsManager.selectedIconHome,iconName: AssetsManager.iconHome, label: AppLocalizations.of(context)!.home),
                buildBottomNavItem(index: 1,iconSelectedName:AssetsManager.selectedIconMap,iconName: AssetsManager.iconMap, label: AppLocalizations.of(context)!.map),
                buildBottomNavItem(index: 2,iconSelectedName:AssetsManager.selectedIconLove,iconName: AssetsManager.iconLove, label: AppLocalizations.of(context)!.favorite),
                buildBottomNavItem(index: 3,iconSelectedName:AssetsManager.selectedIconProfile,iconName: AssetsManager.iconProfile, label: AppLocalizations.of(context)!.profile),
              ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        
      },
        child: Icon(Icons.add,size:35,color: AppColors.whiteColor,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: tabs[selectedIndex],
    );
  }
  BottomNavigationBarItem buildBottomNavItem({required int index,
  required String iconName,required String iconSelectedName, required String label}){
    return BottomNavigationBarItem(
        icon: ImageIcon(AssetImage(selectedIndex == index ? iconSelectedName : iconName)),
        label: label);
  }
}
