import 'package:event_planning/model/event.dart';
import 'package:event_planning/providers/app_theme_provider.dart';
import 'package:event_planning/providers/event_list_provider.dart';
import 'package:event_planning/providers/event_provider.dart';
import 'package:event_planning/providers/user_provider.dart';
import 'package:event_planning/ui/home_screen/tabs/home/event_details/event_details.dart';
import 'package:event_planning/utils/app_colors.dart';
import 'package:event_planning/utils/app_styles.dart';
import 'package:event_planning/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventItemWidget extends StatefulWidget {
  Event event;
  EventItemWidget({required this.event});

  @override
  State<EventItemWidget> createState() => _EventItemWidgetState();
}

class _EventItemWidgetState extends State<EventItemWidget> {

  @override
  Widget build(BuildContext context) {
    EventProvider eventProvider = Provider.of<EventProvider>(context);

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var eventListProvider = Provider.of<EventListProvider>(context);
    var userProvider  = Provider.of<UserProvider>(context);
    return InkWell(
      onTap: () {
        eventProvider.event = widget.event;
        Navigator.of(context).pushNamed(EventDetails.routeName);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.01,
        ),
        margin: EdgeInsets.symmetric(
          horizontal: width * 0.02,
          vertical: height * 0.01),
        height: height * 0.241,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.primaryLight,
            width: 1,
          ),
          image: DecorationImage(image: AssetImage(
              widget.event.image
          ),
              fit: BoxFit.fill),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.01,
              ),
              margin: EdgeInsets.symmetric(
                  horizontal: width * 0.02,
                  vertical: height * 0.01
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: themeProvider.appTheme == ThemeMode.light ?
                    AppColors.whiteColor : AppColors.primaryDark,
              ),
              child: Column(
                children: [
                  Text('${widget.event.dateTime.day}',style: AppStyles.bold20Primary,),
                  Text(DateFormat('MMM').format(widget.event.dateTime),style: AppStyles.bold14Primary)
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.02,
                vertical: height * 0.011890
              ),
              margin: EdgeInsets.symmetric(
                horizontal: width * 0.02,
                vertical: height * 0.009,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  width: 1,
                  color: AppColors.primaryLight
                ),
                color: themeProvider.appTheme == ThemeMode.light ?
                AppColors.whiteColor : AppColors.primaryDark,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.event.title,style: themeProvider.appTheme == ThemeMode.light ?
                  AppStyles.bold14Black : AppStyles.bold14White,),
                  InkWell(
                    onTap: () {
                      eventListProvider.updateFavoriteEventState(widget.event, userProvider.currentUser!.id);
                      setState(() {

                      });
                    },
                    child: widget.event.isFavorite == true ?
                    ImageIcon(AssetImage(AssetsManager.selectedIconLove),
                      color: AppColors.primaryLight,size: 24,)
                        :
                    ImageIcon(AssetImage(AssetsManager.iconLove),
                      color: AppColors.primaryLight,size: 24,),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
