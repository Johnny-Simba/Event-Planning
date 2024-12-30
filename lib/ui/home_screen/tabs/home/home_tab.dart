import 'package:event_planning/providers/app_theme_provider.dart';
import 'package:event_planning/ui/home_screen/tabs/home/event_item_widget.dart';
import 'package:event_planning/ui/home_screen/tabs/home/tab_event_widget.dart';
import 'package:event_planning/utils/app_styles.dart';
import 'package:event_planning/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../../../utils/app_colors.dart';
class HomeTap extends StatefulWidget {

  @override
  State<HomeTap> createState() => _HomeTapState();
}

class _HomeTapState extends State<HomeTap> {
  int isSelectedIndex = 0 ;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    List<String> eventNameList = [
      AppLocalizations.of(context)!.all,
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.holiday,
      AppLocalizations.of(context)!.exhibition,
      AppLocalizations.of(context)!.book_club,
      AppLocalizations.of(context)!.gaming,
      AppLocalizations.of(context)!.eating,
      AppLocalizations.of(context)!.workshop
    ];
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppLocalizations.of(context)!.welcome_back,
                      style: AppStyles.regular14White,),
                    Text('Youssef Mahmoud',style: AppStyles.bold24White,)
                  ],
                )
              ],
            ),
            Row(
              children: [
                Icon(Icons.wb_sunny_outlined,color: AppColors.whiteColor,size: 30,),
                Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: Text(AppLocalizations.of(context)!.language_code,
                    style: themeProvider.appTheme == ThemeMode.light ? AppStyles.bold14Primary :
                    AppStyles.bold14PrimaryDark,),
                )
              ],
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            height: height * 0.11,
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.01
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              )
            ),
            child: Column(
              children: [
                SizedBox( height: height * 0.009,),
                Row(
                  children: [
                    SizedBox(width: width * 0.025,),
                    ImageIcon(AssetImage(AssetsManager.iconMap),color: AppColors.whiteColor,),
                    SizedBox(width: width * 0.0229,),
                    Text('Egypt, Cairo',style: AppStyles.medium14White,)
                  ],
                ),
                SizedBox(height: height * 0.02,),
                DefaultTabController(length: eventNameList.length,
                    child: TabBar(
                      onTap: (index) {
                        isSelectedIndex = index;
                        setState(() {

                        });
                      },
                      dividerColor: AppColors.transparentColor,
                      indicatorColor: AppColors.transparentColor,
                      tabAlignment: TabAlignment.start,
                      labelPadding: EdgeInsets.symmetric(horizontal: width * 0.01),
                      isScrollable: true,
                        tabs: eventNameList.map((eventName){
                          return TabEventWidget(
                            isSelected: isSelectedIndex == eventNameList.indexOf(eventName),
                            eventName: eventName,
                            backgroundColor: AppColors.whiteColor,
                            textSelectedStyle: AppStyles.medium16Primary,
                            textUnSelectedStyle: AppStyles.medium16White,
                          );
                        }).toList()
                    )
                ),
              ],
            ),
          ),
          Expanded(
              child: ListView.builder(
                  itemBuilder: (context, index) {
                    return EventItemWidget();
                  },
                itemCount: 20,
              )
          )
        ],
      ),
    );
  }
}
