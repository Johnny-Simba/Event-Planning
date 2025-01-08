import 'package:event_planning/firebase_utils.dart';
import 'package:event_planning/providers/event_provider.dart';
import 'package:event_planning/ui/home_screen/tabs/home/event_details/edit_event.dart';
import 'package:event_planning/ui/home_screen/tabs/home_screen.dart';
import 'package:event_planning/utils/app_colors.dart';
import 'package:event_planning/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../../../providers/app_theme_provider.dart';
import '../../../../../providers/event_list_provider.dart';
import '../../../../../providers/user_provider.dart';
import '../../../../../utils/app_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../utils/dialog_utils.dart';

class EventDetails extends StatefulWidget {
  const EventDetails({super.key});
  static const String routeName = 'Event Details';

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  late EventListProvider eventListProvider;
  late EventProvider eventProvider;
  late UserProvider userProvider;

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    eventProvider = Provider.of<EventProvider>(context);
    eventListProvider = Provider.of<EventListProvider>(context);
    userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: AppColors.transparentColor,
        title: Text(AppLocalizations.of(context)!.event_details,
          style: themeProvider.appTheme == ThemeMode.light ?
          AppStyles.regular20Primary : AppStyles.regular20White,),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: themeProvider.appTheme ==
              ThemeMode.dark ? AppColors.whiteColor : AppColors.primaryLight,
        ),
        actions: [
          IconButton(onPressed: (){
            Navigator.of(context).pushNamed(EditEvent.routeName);
          }, icon: Image.asset(AssetsManager.editIcon)),
          IconButton(onPressed: (){
            confirmTheDelete();
          }, icon: Image.asset(AssetsManager.removeIcon)),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
        ),
        child: NotificationListener(
          onNotification: (notification) {
            return true;
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: height * 0.24,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.asset(eventProvider.event!.image),
                ),
                SizedBox(height: height * 0.019,),
                Text(eventProvider.event!.title, style: AppStyles.medium24Primary,),
                SizedBox(height: height * 0.019,),
                Container(
                    height: height * 0.08,
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.02,
                      vertical: height * 0.009,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            width: 2,
                            color: AppColors.primaryLight
                        )
                    ),
                    child: Row(
                      children: [
                        Image.asset(AssetsManager.calenderIcon,),
                        SizedBox(width: width * 0.02,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(DateFormat('d MMM y').format(eventProvider.event!.dateTime),
                              style: AppStyles.medium16Primary,),
                            Text(eventProvider.event!.time, style: themeProvider.appTheme == ThemeMode.light ?
                            AppStyles.medium16Black : AppStyles.medium16White,)
                          ],
                        )
                      ],
                    ),
                  ),

                SizedBox(height: height * 0.019,),
                Container(
                    height: height * 0.07,
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.02,
                      vertical: height * 0.009,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            width: 2,
                            color: AppColors.primaryLight
                        )
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(AssetsManager.locationIcon,),
                            SizedBox(width: width * 0.02,),
                            Text('Cairo, Egypt',style: AppStyles.medium16Primary,),
                          ],
                        ),
                        Row(
                          children: [
                            Image.asset(AssetsManager.arrowLocationIcon)
                          ],
                        )
                      ],
                    ),
                  ),

                SizedBox(height: height * 0.019,),
                Container(
                  height: height * 0.43,
                  width: width * 0.9,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.asset(AssetsManager.mapImage,fit: BoxFit.fill,),
                ),
                SizedBox(height: height * 0.019,),
                Text(AppLocalizations.of(context)!.description,
                  style: themeProvider.appTheme == ThemeMode.light ?
                  AppStyles.medium16Black : AppStyles.medium16White,),
                SizedBox(height: height * 0.00951,),
                Text(eventProvider.event!.description, style: themeProvider.appTheme == ThemeMode.light ?
                AppStyles.medium16Black : AppStyles.medium16White,),
                SizedBox(height: height * 0.00951,)
              ],
            ),
          ),
        ),
      ),
    );
  }
  void confirmTheDelete(){
    DialogUtils.showMessage(context: context,
        message: "This event will be permanently deleted. Are you sure you want to delete it?",
        posActionName: 'Keep It', negActionName: 'Delete', negAction: (){
          removeEvent();
        },title: 'Confirm The Delete');
  }
  void removeEvent(){
    FirebaseUtils.removeEventFromFireStore(eventProvider.event!.id, userProvider.currentUser!.id);
    eventListProvider.changeSelectedIndex(0, userProvider.currentUser!.id);
    Navigator.of(context).popUntil(ModalRoute.withName(HomeScreen.routeName));
  }
}
