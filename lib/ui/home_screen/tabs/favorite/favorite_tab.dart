import 'package:event_planning/model/event.dart';
import 'package:event_planning/providers/event_list_provider.dart';
import 'package:event_planning/providers/user_provider.dart';
import 'package:event_planning/utils/app_colors.dart';
import 'package:event_planning/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../../../providers/app_theme_provider.dart';
import '../home/event_item_widget.dart';

class FavoriteTap extends StatefulWidget {

  @override
  State<FavoriteTap> createState() => _FavoriteTapState();
}

class _FavoriteTapState extends State<FavoriteTap> {
  String searchText = '';
  List<Event> searchEventsList = [];

  EventListProvider? eventListProvider;

  @override
  Widget build(BuildContext context) {

    eventListProvider = Provider.of<EventListProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    if(eventListProvider!.favoriteList.isEmpty){
      eventListProvider!.getFavoriteEvents(userProvider.currentUser!.id);
    }
    return  SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.search_for_event,
                  hintStyle: AppStyles.bold14Primary,
                  prefixIcon: Image.asset('assets/images/iconSearch.png'),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                          color: AppColors.primaryLight,
                          width: 2
                      )
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                          color: AppColors.primaryLight,
                          width: 2
                      )
                  ),
                ),
                onChanged: (text) {
                  searchText = text;
                  searchEventsList = eventListProvider!.favoriteList.where((event){
                    return event.title.contains(searchText);
                  }).toList();
                  setState(() {

                  });
                },
                style: themeProvider.appTheme == ThemeMode.light ?
                AppStyles.medium16Black : AppStyles.medium16White,

              )

            ),
            Expanded(
                child:eventListProvider!.favoriteList.isEmpty ? Center(child: Text('No Favorite Events Added'),)
                    : searchText.isNotEmpty ?
                ListView.builder(
                  itemBuilder: (context, index) {
                    return EventItemWidget(event: searchEventsList[index]);
                  },
                  itemCount: searchEventsList.length,
                )
                    :
                ListView.builder(
                  itemBuilder: (context, index) {
                    return EventItemWidget(event: eventListProvider!.favoriteList[index]);
                  },
                  itemCount: eventListProvider!.favoriteList.length,
                )
            )
          ],
        ),
      ),
    );
  }
}
